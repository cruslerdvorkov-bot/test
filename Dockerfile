# OpenResty bundles nginx + LuaJIT + ngx_http_lua (required by access_by_lua_block)
FROM openresty/openresty:alpine

# Install lua-resty-http (provides the `resty.http` module used in nginx.conf)
RUN opm get ledgetech/lua-resty-http

# Copy our nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
