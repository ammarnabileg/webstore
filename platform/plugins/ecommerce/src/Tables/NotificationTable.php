<?php

namespace Botble\Ecommerce\Tables;

use Botble\Ecommerce\Models\Notification;
use Botble\Table\Abstracts\TableAbstract;
use Botble\Table\Actions\DeleteAction;
use Botble\Table\Actions\EditAction;
use Botble\Table\BulkActions\DeleteBulkAction;
use Botble\Table\Columns\CreatedAtColumn;
use Botble\Table\Columns\IdColumn;
use Botble\Table\Columns\Column;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Database\Query\Builder as QueryBuilder;

class NotificationTable extends TableAbstract
{
    public function setup(): void
    {
        $this
            ->model(Notification::class)
            ->addActions([
                EditAction::make()->route('ecommerce.notifications.edit'),
                DeleteAction::make()->route('ecommerce.notifications.destroy'),
            ]);
    }

    public function query(): Relation|Builder|QueryBuilder
    {
        $query = $this
            ->getModel()
            ->query()
            ->select([
                'id',
                'title',
                'type',
                'status',
                'scheduled_at',
                'created_at',
            ]);

        return $this->applyScopes($query);
    }

    public function columns(): array
    {
        return [
            IdColumn::make(),
            Column::make('title')
                ->title(trans('core/base::tables.title'))
                ->route('ecommerce.notifications.edit')
                ->alignLeft(),
            Column::make('type')
                ->title(trans('plugins/ecommerce::ecommerce.type') ?: 'Type')
                ->width(100),
            Column::make('status')
                ->title(trans('core/base::tables.status') ?: 'Status')
                ->width(100),
            Column::make('scheduled_at')
                ->title(trans('plugins/ecommerce::ecommerce.scheduled_at') ?: 'Scheduled At')
                ->width(150),
            CreatedAtColumn::make(),
        ];
    }

    public function buttons(): array
    {
        return $this->addCreateButton(route('ecommerce.notifications.create'), 'ecommerce.notifications.create');
    }

    public function bulkActions(): array
    {
        return [
            DeleteBulkAction::make()->permission('ecommerce.notifications.destroy'),
        ];
    }
}
