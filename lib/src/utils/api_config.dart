final String api_base_url =
    'https://7c96dbbf-3e99-4a26-a937-2fd0c41410a2.mock.pstmn.io/api/v1/';
final String initial_setting_url = api_base_url + 'settings';
final String login_url = api_base_url + 'login';
final String register_url = api_base_url + 'register';
final String reset_password_url = api_base_url + 'send_reset_link_email';
final String food_category_url = api_base_url + 'categories';
final String popular_food_url = api_base_url + 'foods/popular';
final String food_by_category_url =
    api_base_url + 'foods?search=category_id:{categoryid}';
String user_cart_url(apiToken, userId) =>
    api_base_url +
    'carts?api_token={$apiToken}&with=food;extras&search=user_id:{$userId}';
String user_cart_count_url(apiToken, userId) =>
    api_base_url + 'carts/count?api_token={$apiToken}&search=user_id:{$userId}';
String user_add_cart_url(apiToken, resetParam) =>
    api_base_url + 'carts?api_token={$apiToken}&{$resetParam}';
String user_update_cart_url(cartId, apiToken) =>
    api_base_url + 'carts/${cartId}?$apiToken';
String user_remove_cart_url(cartId, apiToken) =>
    api_base_url + 'carts/${cartId}?$apiToken';
