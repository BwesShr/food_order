final String api_base_url =
    'https://7c96dbbf-3e99-4a26-a937-2fd0c41410a2.mock.pstmn.io/api/v1/';
final String initial_setting_url = api_base_url + 'settings';
final String login_url = api_base_url + 'login';
final String register_url = api_base_url + 'register';
final String send_otp_url = api_base_url + 'sendotp';
final String verify_otp_url = api_base_url + 'verifyotp';
final String reset_password_url = api_base_url + 'password/reset';
final String confirm_password_url = api_base_url + 'password/confirm';

final String home_promo_url = api_base_url + 'promo';
final String food_category_url = api_base_url + 'category';
final String trending_food_url = api_base_url + 'foods/trending';
String food_by_category_url(categoryId) =>
    api_base_url + 'category/food?id=$categoryId';
String food_by_details_url(foodId) => api_base_url + 'food?id=$foodId';
String cart_by_details_url(foodId) => api_base_url + 'cart?id=$foodId';

String user_cart_url(apiToken, userId) =>
    api_base_url +
    'carts?api_token={$apiToken}&with=food;extras&search=user_id:{$userId}';
String cart_count_url = api_base_url + 'carts/count';
String user_add_cart_url(resetParam) => api_base_url + 'carts?{$resetParam}';
String user_update_cart_url(cartId) => api_base_url + 'carts/${cartId}';
