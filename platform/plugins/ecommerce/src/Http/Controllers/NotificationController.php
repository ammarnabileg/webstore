<?php

namespace Botble\Ecommerce\Http\Controllers;

if (! defined('NOTIFICATION_MODULE_SCREEN_NAME')) {
    define('NOTIFICATION_MODULE_SCREEN_NAME', 'ecommerce-notification');
}

use Botble\Base\Events\CreatedContentEvent;
use Botble\Base\Events\DeletedContentEvent;
use Botble\Base\Events\UpdatedContentEvent;
use Botble\Base\Facades\PageTitle;
use Botble\Base\Forms\FormBuilder;
use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\Ecommerce\Forms\NotificationForm;
use Botble\Ecommerce\Http\Requests\NotificationRequest;
use Botble\Ecommerce\Jobs\SendFCMNotificationJob;
use Botble\Ecommerce\Models\Notification;
use Botble\Ecommerce\Tables\NotificationTable;
use Exception;
use Illuminate\Http\Request;

class NotificationController extends BaseController
{
    public function index(NotificationTable $table)
    {
        PageTitle::setTitle(trans('plugins/ecommerce::ecommerce.notifications') ?: 'Notifications');

        return $table->renderTable();
    }

    public function create(FormBuilder $formBuilder)
    {
        PageTitle::setTitle(trans('plugins/ecommerce::ecommerce.notifications.create') ?: 'Create Notification');

        return $formBuilder->create(NotificationForm::class)->renderForm();
    }

    public function store(NotificationRequest $request, BaseHttpResponse $response)
    {
        $data = $request->input();

        if (!empty($data['target_id_combined'])) {
            $parts = explode('_', $data['target_id_combined']);
            if (count($parts) === 2) {
                $data['target_type'] = $parts[0];
                $data['target_id'] = (int) $parts[1];
            }
        } else {
            $data['target_id'] = null;
        }

        $isInstantPublish = ($data['status'] === 'published');
        if ($isInstantPublish) {
            $data['status'] = 'sending';
        }

        $notification = Notification::query()->create($data);

        event(new CreatedContentEvent(NOTIFICATION_MODULE_SCREEN_NAME, $request, $notification));

        if ($isInstantPublish) {
            dispatch(new SendFCMNotificationJob($notification));
        }

        return $response
            ->setPreviousUrl(route('ecommerce.notifications.index'))
            ->setNextUrl(route('ecommerce.notifications.edit', $notification->getKey()))
            ->setMessage(trans('core/base::notices.create_success_message'));
    }

    public function edit(Notification $notification, FormBuilder $formBuilder)
    {
        PageTitle::setTitle(trans('plugins/ecommerce::ecommerce.notifications.edit') ?: 'Edit Notification');

        return $formBuilder->create(NotificationForm::class, ['model' => $notification])->renderForm();
    }

    public function update(Notification $notification, NotificationRequest $request, BaseHttpResponse $response)
    {
        $data = $request->input();

        if (!empty($data['target_id_combined'])) {
            $parts = explode('_', $data['target_id_combined']);
            if (count($parts) === 2) {
                $data['target_type'] = $parts[0];
                $data['target_id'] = (int) $parts[1];
            }
        } else {
            $data['target_id'] = null;
        }

        $isInstantPublish = ($data['status'] === 'published' && $notification->status !== 'published');
        if ($isInstantPublish) {
            $data['status'] = 'sending';
        }

        $notification->fill($data);
        $notification->save();

        event(new UpdatedContentEvent(NOTIFICATION_MODULE_SCREEN_NAME, $request, $notification));

        if ($isInstantPublish) {
            dispatch(new SendFCMNotificationJob($notification));
        }

        return $response
            ->setPreviousUrl(route('ecommerce.notifications.index'))
            ->setMessage(trans('core/base::notices.update_success_message'));
    }

    public function destroy(Notification $notification, Request $request, BaseHttpResponse $response)
    {
        try {
            $notification->delete();

            event(new DeletedContentEvent(NOTIFICATION_MODULE_SCREEN_NAME, $request, $notification));

            return $response->setMessage(trans('core/base::notices.delete_success_message'));
        } catch (Exception $exception) {
            return $response
                ->setError()
                ->setMessage($exception->getMessage());
        }
    }
}
