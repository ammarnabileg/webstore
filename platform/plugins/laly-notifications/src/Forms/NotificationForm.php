<?php

namespace Botble\LalyNotifications\Forms;

use Botble\Base\Forms\FieldOptions\DescriptionFieldOption;
use Botble\Base\Forms\FieldOptions\NameFieldOption;
use Botble\Base\Forms\FieldOptions\SelectFieldOption;
use Botble\Base\Forms\Fields\SelectField;
use Botble\Base\Forms\Fields\TextareaField;
use Botble\Base\Forms\Fields\TextField;
use Botble\Base\Forms\Fields\DatePickerField;
use Botble\Base\Forms\FieldOptions\DatePickerFieldOption;
use Botble\Base\Forms\FormAbstract;
use Botble\LalyNotifications\Http\Requests\NotificationRequest;
use Botble\LalyNotifications\Models\Notification;
use Botble\Ecommerce\Models\ProductCategory;
use Botble\Ecommerce\Models\ProductCollection;

class NotificationForm extends FormAbstract
{
    public function setup(): void
    {
        $categories = ProductCategory::query()->wherePublished()->pluck('name', 'id')->all();
        $collections = ProductCollection::query()->wherePublished()->pluck('name', 'id')->all();

        $targetChoices = [
            'none' => trans('plugins/laly-notifications::notifications.none'),
            'category' => trans('plugins/laly-notifications::notifications.category'),
            'collection' => trans('plugins/laly-notifications::notifications.collection'),
            'custom_url' => trans('plugins/laly-notifications::notifications.custom_url'),
        ];

        $targetIdChoices = ['' => trans('plugins/laly-notifications::notifications.select')];
        foreach ($categories as $id => $name) {
            $targetIdChoices['category_' . $id] = 'Category: ' . $name;
        }
        foreach ($collections as $id => $name) {
            $targetIdChoices['collection_' . $id] = 'Collection: ' . $name;
        }

        $model = $this->getModel();
        $selectedTargetId = '';
        if ($model && $model->target_type && $model->target_id) {
            $selectedTargetId = $model->target_type . '_' . $model->target_id;
        }

        $this
            ->setupModel(new Notification())
            ->setValidatorClass(NotificationRequest::class)
            ->withCustomFields()
            ->add('title', TextField::class, NameFieldOption::make()->required()->toArray())
            ->add('description', TextareaField::class, DescriptionFieldOption::make()->toArray())
            ->add('type', SelectField::class, SelectFieldOption::make()
                ->label(trans('plugins/laly-notifications::notifications.type'))
                ->choices([
                    'all' => trans('plugins/laly-notifications::notifications.all'),
                    'guest' => trans('plugins/laly-notifications::notifications.guest'),
                    'logged_in' => trans('plugins/laly-notifications::notifications.logged_in'),
                ])
                ->toArray())
            ->add('target_type', SelectField::class, SelectFieldOption::make()
                ->label(trans('plugins/laly-notifications::notifications.target_type'))
                ->choices($targetChoices)
                ->toArray())
            ->add('target_id_combined', SelectField::class, SelectFieldOption::make()
                ->label(trans('plugins/laly-notifications::notifications.target_id'))
                ->choices($targetIdChoices)
                ->selected($selectedTargetId)
                ->toArray())
            ->add('custom_url', TextField::class, [
                'label' => trans('plugins/laly-notifications::notifications.custom_url'),
                'attr' => ['placeholder' => 'https://...'],
            ])
            ->add('scheduled_at', DatePickerField::class, DatePickerFieldOption::make()
                ->label(trans('plugins/laly-notifications::notifications.scheduled_at'))
                ->defaultValue($model && $model->scheduled_at ? $model->scheduled_at->format('Y-m-d H:i:s') : null)
                ->toArray()
            )
            ->add('status', SelectField::class, SelectFieldOption::make()
                ->label(trans('core/base::tables.status') ?: 'Status')
                ->choices([
                    'draft' => trans('core/base::base.draft') ?: 'Draft',
                    'scheduled' => trans('plugins/laly-notifications::notifications.scheduled'),
                    'published' => trans('core/base::base.published') ?: 'Published (Send Instantly)',
                ])
                ->toArray())
            ->setBreakFieldPoint('scheduled_at');
    }
}
