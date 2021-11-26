<?php namespace App\Controllers;

use App\Models\DashboardModel;

require_once 'Security.php';

class Dashboard extends BaseController
{
    function __construct() {
        session_start();
        $security = new Security();
        $security->isLoginValid();
    }
    
	public function Index() {
        $data = $this->GetDashboardStatistics();
        $data['js_files'][0] = base_url() . '/assets/custom/dashboard/index.js';
        $data['js_files'][1] = base_url() . '/assets/js/pages/dashboard.init.js';
		return view('Dashboard/Index', $data);
    }

    public function GetDashboardStatistics($param = 0) {
        $dashboard_model = new DashboardModel();
        if ($param == 1) {
            return json_encode($dashboard_model->getDashboardStatistics());
        } else {
            return $dashboard_model->getDashboardStatistics();
        }
    }

    public function GetLargestFolders() {
        $dashboard_model = new DashboardModel();
        $response = $dashboard_model->getLargestFolders();
        return json_encode($response);
    }

    public function GetLatestFolders() {
        $dashboard_model = new DashboardModel();
        $response = $dashboard_model->getLatestFolders();
        return json_encode($response);
    }

    public function GetLatestFiles() {
        $dashboard_model = new DashboardModel();
        $response = $dashboard_model->getLatestFiles();
        return json_encode($response);
    }
}