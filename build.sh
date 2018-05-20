docker build -t viabtc_exchange_server .

docker run --rm -v "$PWD":/app -w /app/utils viabtc_exchange_server make $@
docker run --rm -v "$PWD":/app -w /app/network viabtc_exchange_server make $@
docker run --rm -v "$PWD":/app -w /app/readhistory viabtc_exchange_server make $@
docker run --rm -v "$PWD":/app -w /app/accesshttp viabtc_exchange_server make $@
docker run --rm -v "$PWD":/app -w /app/accessws viabtc_exchange_server make $@
# docker run --rm -v "$PWD":/app -w /app/alertcenter viabtc_exchange_server make $@
# docker run --rm -v "$PWD":/app -w /app/marketprice viabtc_exchange_server make $@