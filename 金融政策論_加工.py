import glob
import csv
import os

#
#日付合わせ
#

TO_SAVE_CSV = "金融政策論.csv"

if os.path.isfile(TO_SAVE_CSV) == True:
    os.remove(TO_SAVE_CSV)

to_open_csv = "BTC_JPY 過去データ.csv"

#日付をYYYYMMDD化
with open(to_open_csv, "r", encoding = "utf-8-sig") as f:
    readers = csv.reader(f)
    for row in readers:
        date = row[0]
        old = ["年1月", "年2月", "年3月", "年4月", "年5月", "年6月", "年7月", "年8月", "年9月", "月1日", "月2日", "月3日", "月4日", "月5日", "月6日", "月7日", "月8日", "月9日"]
        new = ["年01月", "年02月", "年03月", "年04月", "年05月", "年06月", "年07月", "年08月", "年09月", "月01日", "月02日", "月03日", "月04日", "月05日", "月06日", "月07日", "月08日", "月09日"]
        for x, y in zip(old, new):
            replaced_date = date = date.replace(x, y)
        row[0] = replaced_date
        with open("temporary.csv", "a", newline = "", encoding = "utf-8-sig") as g:
            writer = csv.writer(g)
            writer.writerow(row)

os.remove(to_open_csv)
os.rename("temporary.csv", to_open_csv)

with open(to_open_csv, "r", encoding = "utf-8-sig") as f:
    readers = csv.reader(f)
    for count, row in enumerate(readers):
        if count == 0:
            date = row[0]
            percent = "BTC_JPY"

        else:
            date = row[0]
            percent = row[6]

        to_write_list = [date, percent]
        with open(TO_SAVE_CSV, "a", newline = "", encoding = "utf-8-sig") as g:
            writer = csv.writer(g)
            writer.writerow(to_write_list)
            print(to_write_list)

for count, to_open_csv in enumerate(glob.glob("元データ/*.csv")):
    file_name = to_open_csv[:-10].split("\\")[-1]

    #日付をYYYYMMDD化
    with open(to_open_csv, "r", encoding = "utf-8-sig") as f:
        readers = csv.reader(f)
        for row in readers:
            date = row[0]
            old = ["年1月", "年2月", "年3月", "年4月", "年5月", "年6月", "年7月", "年8月", "年9月", "月1日", "月2日", "月3日", "月4日", "月5日", "月6日", "月7日", "月8日", "月9日"]
            new = ["年01月", "年02月", "年03月", "年04月", "年05月", "年06月", "年07月", "年08月", "年09月", "月01日", "月02日", "月03日", "月04日", "月05日", "月06日", "月07日", "月08日", "月09日"]
            for x, y in zip(old, new):
                replaced_date = date = date.replace(x, y)
            row[0] = replaced_date
            with open("temporary.csv", "a", newline = "", encoding = "utf-8-sig") as g:
                writer = csv.writer(g)
                writer.writerow(row)

    os.remove(to_open_csv)
    os.rename("temporary.csv", to_open_csv)

    #保存するcsvを開く
    with open(TO_SAVE_CSV, "r", encoding = "utf-8-sig") as f:
        f_readers = csv.reader(f)
        for row_number, f_row in enumerate(f_readers):
            f_date = f_row[0]
            save_list = f_row

            #ヘッダーに追加
            if row_number == 0:
                save_list.append(file_name)
            
            else:
                #引っ張ってくるcsvを開く
                with open(to_open_csv, "r", encoding = "utf-8-sig") as g:
                    g_readers = csv.reader(g)
                    for g_row in g_readers:
                        g_length = len(g_row) - 1
                        g_date = g_row[0]
                        g_growth = g_row[g_length]

                        #日付が合えば、右端に追加
                        if f_date == g_date:
                            save_list.append(g_growth)
            
            if len(save_list) == count + 2:
                save_list.append("")
            
            print(file_name)
            print(save_list)
            with open("temporary.csv", "a", newline = "", encoding = "utf-8-sig") as h:
                writer = csv.writer(h)
                writer.writerow(save_list)
    
    #ファイル名変更
    os.remove(TO_SAVE_CSV)
    os.rename("temporary.csv", TO_SAVE_CSV)


#
#前日ずらし
#

open_csv = "金融政策論.csv"
save_csv = "金融政策論_BTC_USDのみ前日.csv"

with open(open_csv, "r", encoding = "utf-8-sig") as f:
    readers = csv.reader(f)
    for count, row in enumerate(readers):
        if count == 0:
            save_list = row
            with open(save_csv, "a", newline = "", encoding = "utf-8-sig") as g:
                csv.writer(g).writerow(save_list)
            print(save_list)
            for i in range(43):
                header_name = row[i]
                if header_name == "BTC_USD":
                    btc_usd_column = i
                    break
        
        elif count == 1:
            first_half_list = row[0:btc_usd_column]
            latter_half_list = row[btc_usd_column + 1:]
        
        else:
            save_list = first_half_list
            save_list.append(row[btc_usd_column])
            save_list.extend(latter_half_list)
            with open(save_csv, "a", newline = "", encoding = "utf-8-sig") as g:
                csv.writer(g).writerow(save_list)
            print(save_list)
            first_half_list = row[0:btc_usd_column]
            latter_half_list = row[btc_usd_column + 1:]

save_csv = "金融政策論_前日.csv"

with open(open_csv, "r", encoding = "utf-8-sig") as f:
    readers = csv.reader(f)
    for count, row in enumerate(readers):
        if count == 0:
            save_list = row
            with open(save_csv, "a", newline = "", encoding = "utf-8-sig") as g:
                csv.writer(g).writerow(save_list)
            print(save_list)
            for i in range(43):
                header_name = row[i]
                if header_name == "BTC_JPY":
                    btc_jpy_column = i
                    break

        elif count == 1:
            first_half_list = row[0:2]
        
        else:
            save_list = first_half_list
            save_list.extend(row[2:])
            with open(save_csv, "a", newline = "", encoding = "utf-8-sig") as g:
                csv.writer(g).writerow(save_list)
            print(save_list)
            first_half_list = row[0:2]


#
#欠損列削除
#

csv_name = ["金融政策論", "金融政策論_前日", "金融政策論_BTC_USDのみ前日"]

for file_name in csv_name:
    save_file_name = file_name + "_欠損行削除.csv"
    if os.path.isfile(save_file_name) == True:
        os.remove(save_file_name)
    with open(file_name + ".csv", "r", encoding = "utf-8-sig") as f:
        readers = csv.reader(f)
        for row in readers:
            excluded_list = [a for a in row if a != ""]
            row_len = len(excluded_list)

            if row_len == 43:
                with open("temporary.csv", "a", encoding = "utf-8-sig", newline = "") as g:
                    writer = csv.writer(g)
                    writer.writerow(row)
                    print(row)

    with open("temporary.csv", "r", encoding = "utf-8-sig") as f:
        for line in f:
            line = line.replace("%", "")

            with open(save_file_name, "a", newline = "", encoding = "utf-8-sig")as g:
                g.write(line)
                print(line)

    os.remove("temporary.csv")

#
#変化率を01化
#

csv_name = ["金融政策論_欠損行削除", "金融政策論_前日_欠損行削除", "金融政策論_BTC_USDのみ前日_欠損行削除"]

for file_name in csv_name:
    save_file_name = file_name + "_BTC_JPYは01.csv"
    if os.path.isfile(save_file_name) == True:
        os.remove(save_file_name)
    with open(file_name + ".csv", "r", encoding = "utf-8-sig") as f:
        readers = csv.reader(f)
        for count, row in enumerate(readers):
            if count == 0:
                with open(save_file_name, "a", newline = "", encoding = "utf-8-sig") as g:
                    csv.writer(g).writerow(row)
                    print(row)
            
            else:
                percent = float(row[1])

                if percent >0:
                    row[1] = "1"
                
                else:
                    row[1] = "0"
                
                with open(save_file_name, "a", newline = "", encoding = "utf-8-sig") as g:
                    writer = csv.writer(g)
                    writer.writerow(row)
                    print(row)

#
#すべてを01化
#

csv_name = ["金融政策論_欠損行削除", "金融政策論_前日_欠損行削除", "金融政策論_BTC_USDのみ前日_欠損行削除"]

for file_name in csv_name:
    save_file_name = file_name + "_全01.csv"
    if os.path.isfile(save_file_name) == True:
        os.remove(save_file_name)
    with open(file_name + ".csv", "r", encoding = "utf-8-sig") as f:
        readers = csv.reader(f)
        for count, row in enumerate(readers):
            if count == 0:
                with open(save_file_name, "a", newline = "", encoding = "utf-8-sig") as g:
                    csv.writer(g).writerow(row)
                    print(row)
            
            else:
                for i in range(1, 43):
                    percent = float(row[i])

                    if percent >0:
                        row[i] = "1"
                    
                    else:
                        row[i] = "0"
                
                with open(save_file_name, "a", newline = "", encoding = "utf-8-sig") as g:
                    writer = csv.writer(g)
                    writer.writerow(row)
                    print(row)