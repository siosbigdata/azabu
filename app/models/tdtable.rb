# coding: utf-8
# Tdtable Model
# Author:: Kazuko Ohmura
# Date:: 2013.07.31

# TreasureData用データモデル
# == 作成(postgresql)
# create table td_xxx(td_time timestamp with time zone,td_count decimal);
# create table td_hour_xxx(td_time timestamp with time zone,td_count decimal,analysis_type integer);
# create table td_day_xxx(td_time timestamp with time zone,td_count decimal,analysis_type integer);
# create table td_week_xxx(td_time timestamp with time zone,td_count decimal,analysis_type integer);
# create table td_month_xxx(td_time timestamp with time zone,td_count decimal,analysis_type integer);
# xxx部分はGraph.nameとそろえる
class Tdtable < ActiveRecord::Base
end
