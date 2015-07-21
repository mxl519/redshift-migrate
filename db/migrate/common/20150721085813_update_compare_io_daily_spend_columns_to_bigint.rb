class UpdateCompareIoDailySpendColumnsToBigint < ActiveRecord::Migration
  def up
    rename_column :compare_daily_io_spend, :dynamo_spend, :dynamo_spend_old
    add_column    :compare_daily_io_spend, :dynamo_spend, :integer, :limit => 8, :encode => :mostly16

    rename_column :compare_daily_io_spend, :summaries_spend, :summaries_spend_old
    add_column    :compare_daily_io_spend, :summaries_spend, :integer, :limit => 8, :encode => :mostly16

    rename_column :compare_daily_io_spend, :mmx_spend, :mmx_spend_old
    add_column    :compare_daily_io_spend, :mmx_spend, :integer, :limit => 8, :encode => :mostly16

    execute %(
      UPDATE compare_daily_io_spend
      SET dynamo_spend=dynamo_spend_old, summaries_spend=summaries_spend_old, mmx_spend=mmx_spend_old
    )

    remove_column :compare_daily_io_spend, :dynamo_spend_old
    remove_column :compare_daily_io_spend, :summaries_spend_old
    remove_column :compare_daily_io_spend, :mmx_spend_old
  end

  def down
    rename_column :compare_daily_io_spend, :dynamo_spend, :dynamo_spend_old
    add_column    :compare_daily_io_spend, :dynamo_spend, :integer

    rename_column :compare_daily_io_spend, :summaries_spend, :summaries_spend_old
    add_column    :compare_daily_io_spend, :summaries_spend, :integer

    rename_column :compare_daily_io_spend, :mmx_spend, :mmx_spend_old
    add_column    :compare_daily_io_spend, :mmx_spend, :integer

    execute %(
      UPDATE compare_daily_io_spend
      SET dynamo_spend=dynamo_spend_old, summaries_spend=summaries_spend_old, mmx_spend=mmx_spend_old
    )

    remove_column :compare_daily_io_spend, :dynamo_spend_old
    remove_column :compare_daily_io_spend, :summaries_spend_old
    remove_column :compare_daily_io_spend, :mmx_spend_old
  end
end
