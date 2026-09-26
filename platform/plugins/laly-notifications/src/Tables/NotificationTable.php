<?php

namespace Botble\LalyNotifications\Tables;

use Botble\LalyNotifications\Models\Notification;
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
                EditAction::make()->route('laly-notifications.edit'),
                DeleteAction::make()->route('laly-notifications.destroy'),
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
                ->route('laly-notifications.edit')
                ->alignLeft(),
            Column::make('type')
                ->title(trans('plugins/laly-notifications::notifications.type'))
                ->width(100),
            Column::make('status')
                ->title(trans('core/base::tables.status') ?: 'Status')
                ->width(100),
            Column::make('scheduled_at')
                ->title(trans('plugins/laly-notifications::notifications.scheduled_at'))
                ->width(150),
            CreatedAtColumn::make(),
        ];
    }

    public function buttons(): array
    {
        return $this->addCreateButton(route('laly-notifications.create'), 'laly-notifications.create');
    }

    public function bulkActions(): array
    {
        return [
            DeleteBulkAction::make()->permission('laly-notifications.destroy'),
        ];
    }
}
