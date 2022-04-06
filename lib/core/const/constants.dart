RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp phoneRegExp =
    RegExp(r'^(\+0?1\s)?((\d{3})|(\(\d{3}\)))?(\s|-)\d{3}(\s|-)\d{4}$');
RegExp nameRegExp =
    RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
RegExp passwordRegExp =
    RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");


// remote
const String baseUrl = 'https://jobs-proj.herokuapp.com/api/';
const String loginEndPoint = 'login';
const String registerEndPoint = 'register';
const String jobsEndPoint = 'jobs';
const String logoutEndPoint = 'logout';
const String appliedJobEndPoint = 'appliedJob';
const String authorizationHeader = 'Authorization';
const String bearerToken = 'Bearer';

// local keys
const String tokenKey = 'token_key';
const String userIdKey = 'user_id_key';