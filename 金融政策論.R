#金融政策論 レポート

#グラフの設定
ps.options(family = "Japan1GothicBBB", pointsize = 16)

#ライブラリ読み込み
library(car)
library(dplyr)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#
#重回帰分析
#

#当日のデータを使用
finance <- read.csv("金融政策論_欠損行削除.csv", header = TRUE, encoding = "UTF-8")[ ,2:43]
finance.full.lm <- lm(BTC_JPY ~ ., data = finance)
finance.null.lm <- lm(BTC_JPY ~ 1, data = finance)

finance.lm <- step(finance.null.lm, direction = "both", scope = list(lower = finance.null.lm, upper = finance.full.lm))
summary(finance.lm)

#多重共線性をとりのぞいたモデル
finance.lm <- lm(BTC_JPY ~ BTC_USD + GLD + EUR_JPY + GBP_USD + オーストラリアS.P_ASX.200 + S.P500 + EUR_USD + CHF_JPY + JNJ, data = finance)
summary(finance.lm)
vif(finance.lm)

plot(finance$BTC_JPY, finance.lm$fitted.values, xlab = "観測値", ylab = "予測値", main = "当日データ")
plot(finance$BTC_JPY, finance.lm$fitted.values, xlim = c(-40, 40), ylim = c(-40, 40), xlab = "観測値", ylab = "予測値", main = "当日データ")
plot(finance$BTC_JPY, finance.lm$fitted.values, xlim = c(-25, 25), ylim = c(-25, 25), xlab = "観測値", ylab = "予測値", main = "当日データ")
plot(finance$BTC_JPY, finance.lm$fitted.values, xlim = c(-10, 10), ylim = c(-10, 10), xlab = "観測値", ylab = "予測値", main = "当日データ")
plot(finance$BTC_JPY, finance.lm$fitted.values, xlim = c(-5, 5), ylim = c(-5, 5), xlab = "観測値", ylab = "予測値", main = "当日データ")



#BTC_USDのみ前日のデータを使用
finance.previous_day <- read.csv("金融政策論_BTC_USDのみ前日_欠損行削除.csv", header = TRUE, encoding = "UTF-8")[ ,2:43]
finance.previous_day.full.lm <- lm(BTC_JPY ~ ., data = finance.previous_day)
finance.previous_day.null.lm <- lm(BTC_JPY ~ 1, data = finance.previous_day)

finance.previous_day.lm <- step(finance.previous_day.null.lm, direction = "both", scope = list(lower = finance.previous_day.null.lm, upper = finance.previous_day.full.lm))
summary(finance.previous_day.lm)

finance.previous_day.lm <- lm(BTC_JPY ~ ナスダック100 + 韓国総合株価指数 + ドイツDAX指数 + 銀先物 + オーストラリアS.P_ASX.200 + LP62007031, data = finance.previous_day)
summary(finance.previous_day.lm)
vif(finance.previous_day.lm)

plot(finance.previous_day$BTC_JPY, finance.previous_day.lm$fitted.values, xlab = "観測値", ylab = "予測値", main = "BTC/USDのみ前日のデータ")
plot(finance.previous_day$BTC_JPY, finance.previous_day.lm$fitted.values, xlim = c(-40, 40), ylim = c(-40, 40), xlab = "観測値", ylab = "予測値", main = "BTC/USDのみ前日のデータ")
plot(finance.previous_day$BTC_JPY, finance.previous_day.lm$fitted.values, xlim = c(-25, 25), ylim = c(-25, 25), xlab = "観測値", ylab = "予測値", main = "BTC/USDのみ前日のデータ")
plot(finance.previous_day$BTC_JPY, finance.previous_day.lm$fitted.values, xlim = c(-10, 10), ylim = c(-10, 10), xlab = "観測値", ylab = "予測値", main = "BTC/USDのみ前日のデータ")
plot(finance.previous_day$BTC_JPY, finance.previous_day.lm$fitted.values, xlim = c(-5, 5), ylim = c(-5, 5), xlab = "観測値", ylab = "予測値", main = "BTC/USDのみ前日のデータ")

#BTC/USDを加えたモデル
finance.previous_day.lm <- lm(BTC_JPY ~ BTC_USD + ナスダック100 + 韓国総合株価指数 + ドイツDAX指数 + 銀先物 + オーストラリアS.P_ASX.200 + LP62007031, data = finance.previous_day)
summary(finance.previous_day.lm)



#全説明変数が前日のデータを使用
finance.all_previous_day <- read.csv("金融政策論_前日_欠損行削除.csv", header = TRUE, encoding = "UTF-8")[ ,2:43]
finance.all_previous_day.full.lm <- lm(BTC_JPY ~ ., data = finance.all_previous_day)
finance.all_previous_day.null.lm <- lm(BTC_JPY ~ 1, data = finance.all_previous_day)

finance.all_previous_day.lm <- step(finance.all_previous_day.null.lm, direction = "both", scope = list(lower = finance.all_previous_day.null.lm, upper = finance.all_previous_day.full.lm))
summary(finance.all_previous_day.lm)

finance.all_previous_day.lm <- lm(BTC_JPY ~ USD_KRW + GBP_USD, data = finance.all_previous_day)
summary(finance.all_previous_day.lm)
vif(finance.all_previous_day.lm)

plot(finance.all_previous_day$BTC_JPY, finance.all_previous_day.lm$fitted.values, xlab = "観測値", ylab = "予測値", main = "全説明変数が前日のデータ")
plot(finance.all_previous_day$BTC_JPY, finance.all_previous_day.lm$fitted.values, xlim = c(-40, 40), ylim = c(-40, 40), xlab = "観測値", ylab = "予測値", main = "全説明変数が前日のデータ")
plot(finance.all_previous_day$BTC_JPY, finance.all_previous_day.lm$fitted.values, xlim = c(-25, 25), ylim = c(-25, 25), xlab = "観測値", ylab = "予測値", main = "全説明変数が前日のデータ")
plot(finance.all_previous_day$BTC_JPY, finance.all_previous_day.lm$fitted.values, xlim = c(-10, 10), ylim = c(-10, 10), xlab = "観測値", ylab = "予測値", main = "全説明変数が前日のデータ")
plot(finance.all_previous_day$BTC_JPY, finance.all_previous_day.lm$fitted.values, xlim = c(-5, 5), ylim = c(-5, 5), xlab = "観測値", ylab = "予測値", main = "全説明変数が前日のデータ")




#
#ロジスティック回帰(全ての変数がダミー変数)
#

#ロジスティック回帰分析(全ての変数がダミー変数)
finance.logistic <- read.csv("金融政策論_欠損行削除_全01.csv", header = TRUE, encoding = "UTF-8")[, 2:43]
finance.logistic.full.glm <- glm(BTC_JPY ~ ., family = binomial, data = finance.logistic)
finance.logistic.null.glm <- glm(BTC_JPY ~ 1, family = binomial, data = finance.logistic)

finance.logistic.glm <- step(finance.logistic.null.glm, direction = "both", scope = list(lower = finance.logistic.null.glm, upper = finance.logistic.full.glm))
summary(finance.logistic.glm)

finance.logistic.glm <- glm(BTC_JPY ~ BTC_USD + BRL_JPY + イギリス.Gilt先物 + 米ドル指数先物 + EUR_JPY + SPY + 日経平均株価 + ユーロ.SCHATZ先物 + 金先物 + 銅先物 + BAC + LP62009792, family = binomial, data = finance.logistic)
summary(finance.logistic.glm)
vif(finance.logistic.glm)

plot(finance.logistic.glm$fitted.values)
plot(finance.logistic.glm$fitted.values, finance.logistic$BTC_USD)
plot(finance.logistic.glm$fitted.values, finance.logistic$BTC_JPY)

finance.data <- finance.logistic %>%
  mutate(predict = predict(finance.logistic.glm, type = "response"), pct = if_else(predict >= 0.5, 1, 0))
sum(finance.data$BTC_JPY == finance.data$pct)/nrow(finance.data)


#ロジスティック回帰分析(全ての変数がダミー変数,BTC_USDのみ前日)
finance.logistic.previous_day <- read.csv("金融政策論_BTC_USDのみ前日_欠損行削除_全01.csv", header = TRUE, encoding = "UTF-8")[, 2:43]
finance.logistic.previous_day.full.glm <- glm(BTC_JPY ~ ., family = binomial, data = finance.logistic.previous_day)
finance.logistic.previous_day.null.glm <- glm(BTC_JPY ~ 1, family = binomial, data = finance.logistic.previous_day)

finance.logistic.previous_day.glm <- step(finance.logistic.previous_day.null.glm, direction = "both", scope = list(lower = finance.logistic.previous_day.null.glm, upper = finance.logistic.previous_day.full.glm))
summary(finance.logistic.previous_day.glm)

finance.logistic.previous_day.glm <- glm(BTC_JPY ~ ナスダック100 + ユーロ.Bund先物 + CHF_JPY + オーストラリアS.P_ASX.200 + AAPL + JNJ + 米2年国債先物 + BAC + 仏CAC40 + 韓国総合株価指数 + GLD + ユーロ.SCHATZ先物, family = binomial, data = finance.logistic.previous_day)
summary(finance.logistic.previous_day.glm)
vif(finance.logistic.previous_day.glm)

plot(finance.logistic.previous_day.glm$fitted.values)
plot(finance.logistic.previous_day.glm$fitted.values, finance.logistic.previous_day$BTC_USD)
plot(finance.logistic.previous_day.glm$fitted.values, finance.logistic.previous_day$BTC_JPY)

finance.logistic.data.previous_day <- finance.logistic.previous_day %>%
  mutate(predict = predict(finance.logistic.previous_day.glm, type = "response"), pct = if_else(predict >= 0.5, 1, 0))
sum(finance.logistic.data.previous_day$BTC_JPY == finance.logistic.data.previous_day$pct)/nrow(finance.logistic.data.previous_day)


#ロジスティック回帰分析(全ての変数がダミー変数,全説明変数が前日)
finance.logistic.all_previous_day <- read.csv("金融政策論_前日_欠損行削除_全01.csv", header = TRUE, encoding = "UTF-8")[, 2:43]
finance.logistic.all_previous_day.full.glm <- glm(BTC_JPY ~ ., family = binomial, data = finance.logistic.all_previous_day)
finance.logistic.all_previous_day.null.glm <- glm(BTC_JPY ~ 1, family = binomial, data = finance.logistic.all_previous_day)

finance.logistic.all_previous_day.glm <- step(finance.logistic.all_previous_day.null.glm, direction = "both", scope = list(lower = finance.logistic.all_previous_day.null.glm, upper = finance.logistic.all_previous_day.full.glm))
summary(finance.logistic.all_previous_day.glm)

finance.logistic.all_previous_day.glm <- glm(BTC_JPY ~ EUR_JPY + GBP_USD + ナスダック100 + JNJ + 銀先物 + 韓国総合株価指数 + 香港ハンセン, family = binomial, data = finance.logistic.all_previous_day)
summary(finance.logistic.all_previous_day.glm)
vif(finance.logistic.all_previous_day.glm)

plot(finance.logistic.all_previous_day.glm$fitted.values)
plot(finance.logistic.all_previous_day.glm$fitted.values, finance.logistic.all_previous_day$BTC_USD)
plot(finance.logistic.all_previous_day.glm$fitted.values, finance.logistic.all_previous_day$BTC_JPY)

finance.logistic.data.all_previous_day <- finance.logistic.all_previous_day %>%
  mutate(predict = predict(finance.logistic.all_previous_day.glm, type = "response"), pct = if_else(predict >= 0.5, 1, 0))
sum(finance.logistic.data.all_previous_day$BTC_JPY == finance.logistic.data.all_previous_day$pct)/nrow(finance.logistic.data.all_previous_day)






