<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Datetime;
use App\Events\NewMessageNotification;

class Mobile extends Controller
{

 
    public function send()
    {
        // ...
         
        // message is being sent

         
        // want to broadcast NewMessageNotification event
        event(new NewMessageNotification("Limit and Low budget Notification"));
         
        return "Notification is sent";
    }

    public function Enter(Request $request)
    {
        $username = $request->route("username");
        $password = $request->route("password");

        $user = DB::table('users')->where([
            ["username", $username],
            ["password", $password]
        ])->first();

        $tb = DB::table('bankcards')->where("userId", $user->id)->sum('totalAmount');
        $transactions = DB::table('transactions')
        ->join('categories', 'transactions.categoryId', '=','categories.id')
        ->join('bankcards', 'transactions.cardId', '=','bankcards.id')
        ->select('transactions.*','categories.name AS category', 'bankcards.cardNumber AS cardNumber')
        ->where('transactions.userId', $user->id)
        ->get();

        $activity = DB::table('activities')
        ->join('categories', 'activities.categoryId', '=','categories.id')
        ->select('activities.*','categories.name AS category')
        ->where("activities.userId", $user->id)
        ->get();
        
        $card = DB::table('bankcards')
        ->join('cardtypes', 'bankcards.cardTypeId', '=','cardtypes.id')
        ->select('bankcards.*','cardtypes.type AS name')
        ->where("bankcards.userId", $user->id)
        ->get();

        $weekdate = new DateTime('-1 week');
        $weekdate = $weekdate->format('Y-m-d H:i:s');
        
        $weekTrans = $transactions->whereBetween("date", [$weekdate,date("Y-m-d H:i:s")]);
        $weekWithdraw = $weekTrans->where("categoryId", 1)->sum("money");
        $weekTransfer = $weekTrans->where("categoryId", 2)->sum("money");
        $weekShoping = $weekTrans->where("categoryId", 3)->sum("money");

        $daydate = new DateTime('-1 day');
        $daydate = $daydate->format('Y-m-d H:i:s');

        $dayTrans = $transactions->whereBetween("date",[$daydate,date("Y-m-d H:i:s")]);
        $dayWithdraw = $dayTrans->where("categoryId", 1)->sum("money");
        $dayTransfer = $dayTrans->where("categoryId", 2)->sum("money");
        $dayShoping = $dayTrans->where("categoryId", 3)->sum("money");


        $monthdate = new DateTime('-1 month');
        $monthdate = $monthdate->format('Y-m-d H:i:s');

        $monthTrans = $transactions->whereBetween("date", [$monthdate, date("Y-m-d H:i:s")]);
        $monthWithdraw = $monthTrans->where("categoryId", 1)->sum("money");
        $monthTransfer = $monthTrans->where("categoryId", 2)->sum("money");
        $monthShoping = $monthTrans->where("categoryId", 3)->sum("money");

        $user->cards = $card;
        $user->countcards = count($card);
        $user->today = array('withdraw' => $dayWithdraw, 'transfer' => $dayTransfer, 'shoping' => $dayShoping);
        $user->month = array('withdraw' => $monthWithdraw, 'transfer' => $monthTransfer, 'shoping' => $monthShoping);
        $user->week = array('withdraw' => $weekWithdraw, 'transfer' => $weekTransfer, 'shoping' => $weekShoping);
        $user->fullname = $user->name. ' '. $user->surname;
        $user->totalBalance = $tb;
        $user->transactions = $transactions;
        $user->transactionsCount = count($transactions);
        $user->activity = $activity;
        return response()->json($user, 200);
    }


}
