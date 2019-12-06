<?php

Route::group(['prefix' => 'api'], function () {
Route::get('user/{username}/{password}', "Mobile@Enter");    
});

Route::get('/', "Mobile@send");