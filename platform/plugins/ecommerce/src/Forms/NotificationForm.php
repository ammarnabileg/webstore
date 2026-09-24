<?php

namespace Botble\Ecommerce\Forms;

use Botble\Base\Forms\FieldOptions\DescriptionFieldOption;
use Botble\Base\Forms\FieldOptions\NameFieldOption;
use Botble\Base\Forms\FieldOptions\SelectFieldOption;
use Botble\Base\Forms\Fields\SelectField;
use Botble\Base\Forms\Fields\TextareaField;
use Botble\Base\Forms\Fields\TextField;
use Botble\Base\Forms\Fields\DatePickerField;
use Botble\Base\Forms\FieldOptions\DatePickerFieldOption;
use Botble\Base\Forms\FormAbstract;
use Botble\Ecommerce\Http\Requests\NotificationRequest;
use Botble\Ecommerce\Models\Notification;
use Botble\Ecommerce\Models\ProductCategory;
use Botble\Ecommerce\Models\ProductCollection;

class NotificationForm extends FormAbstract
{
    public function setup(): void
    {
        $categories = ProductCategory::query()->wherePublished()->pluck('name', 'id')->all();
        $collections = ProductCollection::query()->wherePublished()->pluck('name', 'id')->all();

        $targetChoices = [
            'none' => trans('plugins/ecommerce::ecommerce.none') ?: 'None',
            'category' => trans('plugins/ecommerce::ecommerce.category') ?: 'Category',
            'collection' => trans('plugins/ecommerce::ecommerce.collection') ?: 'Collection',
            'custom_url' => trans('plugins/ecommerce::ecommerce.custom_url') ?: 'Custom URL',
        ];

        $targetIdChoices = ['' => trans('plugins/ecommerce::ecommerce.select') ?: '-- Select --'];
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
                ->label(trans('plugins/ecommerce::ecommerce.type') ?: 'Target Audience')
                ->choices([
                    'all' => trans('plugins/ecommerce::ecommerce.all') ?: 'All (Guests & Logged In)',
                    'guest' => trans('plugins/ecommerce::ecommerce.guest') ?: 'Guests Only',
                    'logged_in' => trans('plugins/ecommerce::ecommerce.logged_in') ?: 'Logged In Users Only',
                ])
                ->toArray())
            ->add('target_type', SelectField::class, SelectFieldOption::make()
                ->label(trans('plugins/ecommerce::ecommerce.target_type') ?: 'Target Link Type')
                ->choices($targetChoices)
                ->toArray())
            ->add('target_id_combined', SelectField::class, SelectFieldOption::make()
                ->label(trans('plugins/ecommerce::ecommerce.target_id') ?: 'Target Category / Collection')
                ->choices($targetIdChoices)
                ->selected($selectedTargetId)
                ->toArray())
            ->add('custom_url', TextField::class, [
                'label' => trans('plugins/ecommerce::ecommerce.custom_url') ?: 'Custom URL',
                'attr' => ['placeholder' => 'https://...'],
            ])
            ->add('scheduled_at', DatePickerField::class, DatePickerFieldOption::make()
                ->label(trans('plugins/ecommerce::ecommerce.scheduled_at') ?: 'Scheduled Date & Time')
                ->defaultValue($model && $model->scheduled_at ? $model->scheduled_at->format('Y-m-d H:i:s') : null)
                ->toArray()
            )
            ->add('status', SelectField::class, SelectFieldOption::make()
                ->label(trans('core/base::tables.status') ?: 'Status')
                ->choices([
                    'draft' => trans('core/base::base.draft') ?: 'Draft',
                    'scheduled' => trans('plugins/ecommerce::ecommerce.scheduled') ?: 'Scheduled',
                    'published' => trans('core/base::base.published') ?: 'Published (Send Instantly)',
                ])
                ->toArray())
            ->setBreakFieldPoint('scheduled_at');
    }
}
