require "csv"
require "nkf"

today = Date.current
range = today.beginning_of_financial_year..today.end_of_financial_year
id_col = []
name_col = []

csvs = CSV.generate do |csv|
  @lab.members.each do |member|
    id_col << member.id
    name_col << member.lastname+member.firstname
  end

  csv << name_col
  csv << id_col
  csv << []
  csv << ["注意事項"]
  csv << ["・UNIXTIMEは60で割れば[min]に, 3600で割れば[hour]になります"]
  csv << ["・ステータスは作成日時以前のものを表し, そのステータスでいた時間がUNIXTIMEになります"]
  csv << []
  csv << ["作成日時", "ステータス", "時間(UNIXTIME)", "メンバーID(上記参照)"]

  @lab.members.each do |member|
    logs = member.each_logs_at_day(range, Member.statuses.values)

    logs.each do |log|
      csv << [log.created_at, log.status_i18n, log.total_time, member.id]
    end
  end
end

NKF.nkf("--sjis -Lw", csvs)