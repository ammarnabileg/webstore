<?php

namespace Botble\LalyNotifications\Http\Controllers;

use Botble\Base\Events\CreatedContentEvent;
use Botble\Base\Events\DeletedContentEvent;
use Botble\Base\Events\UpdatedContentEvent;
use Botble\Base\Facades\PageTitle;
use Botble\Base\Forms\FormBuilder;
use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\LalyNotifications\Forms\NotificationForm;
use Botble\LalyNotifications\Http\Requests\NotificationRequest;
use Botble\LalyNotifications\Jobs\SendFCMNotificationJob;
use Botble\LalyNotifications\Models\Notification;
use Botble\LalyNotifications\Tables\NotificationTable;
use Exception;
use Illuminate\Http\Request;

class NotificationController extends BaseController
{
    protected const SCREEN = 'laly-notification';

    public function index(NotificationTable $table)
    {
        PageTitle::setTitle(trans('plugins/laly-notifications::notifications.notifications'));

        return $table->renderTable();
    }

    public function create(FormBuilder $formBuilder)
    {
        PageTitle::setTitle(trans('plugins/laly-notifications::notifications.create_notification'));

        return $formBuilder->create(NotificationForm::class)->renderForm();
    }

    public function store(NotificationRequest $request, BaseHttpResponse $response)
    {
        [$data, $sendNow] = $this->prepareData($request, null);

        $notification = Notification::query()->create($data);

        event(new CreatedContentEvent(self::SCREEN, $request, $notification));

        if ($sendNow) {
            SendFCMNotificationJob::dispatch($notification);
        }

        return $response
            ->setPreviousUrl(route('laly-notifications.index'))
            ->setNextUrl(route('laly-notifications.edit', $notification->getKey()))
            ->setMessage(trans('core/base::notices.create_success_message'));
    }

    public function edit(Notification $notification, FormBuilder $formBuilder)
    {
        PageTitle::setTitle(trans('plugins/laly-notifications::notifications.edit_notification'));

        return $formBuilder->create(NotificationForm::class, ['model' => $notification])->renderForm();
    }

    public function update(Notification $notification, NotificationRequest $request, BaseHttpResponse $response)
    {
        [$data, $sendNow] = $this->prepareData($request, $notification);

        $notification->fill($data)->save();

        event(new UpdatedContentEvent(self::SCREEN, $request, $notification));

        if ($sendNow) {
            SendFCMNotificationJob::dispatch($notification);
        }

        return $response
            ->setPreviousUrl(route('laly-notifications.index'))
            ->setMessage(trans('core/base::notices.update_success_message'));
    }

    public function destroy(Notification $notification, Request $request, BaseHttpResponse $response)
    {
        try {
            $notification->delete();

            event(new DeletedContentEvent(self::SCREEN, $request, $notification));

            return $response->setMessage(trans('core/base::notices.delete_success_message'));
        } catch (Exception $exception) {
            return $response->setError()->setMessage($exception->getMessage());
        }
    }

    /**
     * @return array{0: array, 1: bool} validated data, and whether to push it now
     */
    protected function prepareData(NotificationRequest $request, ?Notification $existing): array
    {
        $data = $request->validated();

        [$type, $id] = array_pad(explode('_', (string) ($data['target_id_combined'] ?? ''), 2), 2, null);
        if (in_array($data['target_type'], ['category', 'collection'], true) && $type === $data['target_type'] && ctype_digit((string) $id)) {
            $data['target_id'] = (int) $id;
        } else {
            $data['target_id'] = null;
        }
        unset($data['target_id_combined']);

        // "published" means send now; an already-sent notification is not pushed again on edit.
        $sendNow = $data['status'] === 'published' && (! $existing || ! in_array($existing->status, ['published', 'sending'], true));
        if ($sendNow) {
            $data['status'] = 'sending';
        } elseif ($data['status'] === 'published' && $existing) {
            $data['status'] = $existing->status;
        }

        return [$data, $sendNow];
    }
}
