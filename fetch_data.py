import requests
import pandas as pd

url = "https://api.coingecko.com/api/v3/coins/markets"
params = {
    "vs_currency": "usd",
    "order": "market_cap_desc",
    "per_page": 200,
    "page": 1,
    "price_change_percentage": "1h,24h,7d",
}

response = requests.get(url, params=params, timeout=30)
data = response.json()

df = pd.DataFrame(data)[[
    "market_cap_rank", "name", "symbol", "current_price",
    "price_change_percentage_1h_in_currency",
    "price_change_percentage_24h_in_currency",
    "price_change_percentage_7d_in_currency",
    "market_cap", "total_volume", "circulating_supply",
]]

df.columns = ["Rank", "Name", "Symbol", "Price", "Chg1h", "Chg24h",
              "Chg7d", "MarketCap", "Volume24h", "CircSupply"]
df["Symbol"] = df["Symbol"].str.upper()

df.to_csv("crypto_data.csv", index=False)
print("Saved", len(df), "coins")
print(df.head())