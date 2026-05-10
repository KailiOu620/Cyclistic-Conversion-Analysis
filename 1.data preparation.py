#利用python自动化清洗12个月分别CSV文件中的数据
import pandas as pd
#读取数据
data1 = pd.read_csv(r"C:\Users\区凯丽\Desktop\CASE1\数据\202306-divvy-tripdata.csv")

#删除缺少列：ride_id，started_at,ended_at，member_casual的空白值
data1.columns = data1.columns.str.strip().str.replace('\n', '').str.replace('\r', '')
data1 = data1.dropna(subset=["ride_id", "started_at", "ended_at", "member_casual"])

#去除重复数据
data1.drop_duplicates()

#删除异常值（删除骑行时长小于60秒，大于一天的数据）
data1['started_at'] = pd.to_datetime(data1['started_at'])
data1['ended_at'] = pd.to_datetime(data1['ended_at'])
data1['ride_length_seconds'] = (data1['ended_at'] - data1['started_at']).dt.total_seconds()
data1= data1[(data1['ride_length_seconds'] >= 60) & (data1['ride_length_seconds'] <= 86400)]

#时间格式标准化
data1['ride_length'] = pd.to_datetime(data1['ride_length_seconds'], unit='s').dt.strftime('%H:%M:%S')

#特征工程处理
#计算ride_length，输出为HH:MM:SS形式
data1['started_at'] = pd.to_datetime(data1['started_at'])
data1['ended_at'] = pd.to_datetime(data1['ended_at'])
data1['ride_length_seconds'] = (data1['ended_at'] - data1['started_at']).dt.total_seconds()
def sec_to_hhmmss(seconds):
    h = int(seconds // 3600)
    m = int((seconds % 3600) // 60)
    s = int(seconds % 60)
    return f"{h:02d}:{m:02d}:{s:02d}"
data1['ride_length'] = data1['ride_length_seconds'].apply(sec_to_hhmmss)

#计算星期几（1=周日，7=周六）
data1['day_of_week'] = data1['started_at'].dt.weekday
data1['day_of_week'] = data1['day_of_week'].apply(lambda x: 1 if x == 6 else x + 2)

#保存文件
data1.to_csv(
    r"C:\Users\区凯丽\Desktop\CASE1\数据\202306—cleaned_data.csv",
    index=False,
    encoding='utf-8-sig'
)
