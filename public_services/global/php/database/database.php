<?php	

	class database{		
		private $link=false;


		public function __construct($db_name = ""){

			require_once(__DIR__.DIRECTORY_SEPARATOR."connection.php");
			$connectionData = getConnectionData();

			$this->link = new mysqli(
				$connectionData["host"]
				,$connectionData["user"]
				,$connectionData["pass"]
				,$db_name
			);

			if($this->link){
				$this->link->autocommit(false);
			}
			return $this->link;
		}

		public function getData($query, $data=[]){
			$result = $this->link->query($query);
			if($result==false){
				echo $this->errorText()."\n".$query;
				exit();
			}
			while($row = $result->fetch_array(MYSQLI_ASSOC)){
				$data[] = $row;
			}
			return $data;
		}

		public function execute($query){
			$success = $this->link->query($query);
			return $success;
		}
		public function commit(){
			$this->link->commit();
		}
		public function rollback(){
			$this->link->rollback();
		}
		public function close(){
			$this->link->close();
		}

		public function errorText(){
			return $this->link->error;
		}

		public function getLastID(){
			return $this->link->insert_id;
		}
		public function escapeString($input){
			return $this->link->real_escape_string($input);
		}
	}

?>
