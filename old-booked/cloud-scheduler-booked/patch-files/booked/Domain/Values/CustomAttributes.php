<?php

/**
 * Copyright 2013-2014 Nick Korbel
 *
 * This file is part of Booked Scheduler.
 *
 * Booked Scheduler is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Booked Scheduler is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Booked Scheduler.  If not, see <http://www.gnu.org/licenses/>.
 */
class CustomAttributes
{
	private $attributes = array();

	// SSM: ReservationAttrs = "CPUs" = 7, "Memory (Gb)" = 8
	public static $reservationAttrs = array( 'cpus' => 7, 'memory' => 8 );
	// SSM: ResourceAttrs = "Available CPUs (total)" = 1, "Available Memory (Gb)" = 2
	public static $resourceAttrs = array( 'cpus' => 1, 'memory' => 2 );

	/**
	 * @param string $attributes
	 * @return CustomAttributes
	 */
	public static function Parse($attributes)
	{
		$ca = new CustomAttributes();

		if (empty($attributes))
		{
			return $ca;
		}

		$pairs = explode('!sep!', $attributes);

		foreach ($pairs as $pair)
		{
			$nv = explode('=', $pair);
			$ca->Add($nv[0], $nv[1]);
		}

		return $ca;
	}

	/**
	 * @param $name string
	 * @param $value string
	 */
	public function Add($name, $value)
	{
		$this->attributes[$name] = $value;
	}

	/**
	 * @param $id int
	 * @return null|string
	 */
	public function Get($id)
	{
		if (array_key_exists($id, $this->attributes))
		{
			return $this->attributes[$id];
		}

		return null;
	}

	/**
	 * @return array|string[]
	 */
	public function All()
	{
		return $this->attributes;
	}

	/**
	 * @param int $id
	 * @return bool
	 */
	public function Contains($id)
	{
		return array_key_exists($id, $this->attributes);
	}

	/**
	 * SSM: Calculate the capacity left on resource (with provided attributes)
         *      based on provided reservations
	 *
	 * @param array|ReservationViewItem[]
	 * @param array|CustomAttribute[] (key is custom attribute id)
	 * @return float, int, int
	 */
	public static function GetCapacityLeft($reservations, $resourceAttributes)
	{
		$totalCpus = 0;
		$totalMemory = 0;
		$cpuAttr = $resourceAttributes[CustomAttributes::$resourceAttrs['cpus']];
		$memAttr = $resourceAttributes[CustomAttributes::$resourceAttrs['memory']];
		if ( method_exists($cpuAttr, "Value") ) {
			$totalCpus = $cpuAttr->Value();
			$totalMemory = $memAttr->Value();
		} else {
			$totalCpus = $cpuAttr->Value;
			$totalMemory = $memAttr->Value;
		}

		$usedCpus = 0;
		$usedMemory = 0;
		foreach( $reservations  as $reservation ) {
			if ( $reservation->Attributes ) {
				$reservedCpus = $reservation->Attributes->Get(CustomAttributes::$reservationAttrs['cpus']);
				$usedCpus += $reservedCpus;
				$reservedMemory = $reservation->Attributes->Get(CustomAttributes::$reservationAttrs['memory']);
				$reservedTotalMemory = $reservedMemory;
				$usedMemory += $reservedTotalMemory;
			}
		}
		$availCpus = $totalCpus - $usedCpus;
		$availMemory = $totalMemory - $usedMemory;
		$capacity = min( $availCpus/$totalCpus, $availMemory/$totalMemory );

		return array( $capacity, $availCpus, $availMemory );
	}

	/**
	 * SSM: Extract capacity attributes from resource attributes
	 *
	 * @param array|CustomAttribute[] (key is custom attribute id)
	 * @return (CustomAttribute, CustomAttribute)
	 */
	public static function GetCapacityAttributes($resourceAttributes)
	{
		$cpuAttribute = $resourceAttributes[CustomAttributes::$resourceAttrs['cpus']]->AttributeDefinition();
		$memoryAttribute = $resourceAttributes[CustomAttributes::$resourceAttrs['memory']]->AttributeDefinition();

		return array( $cpuAttribute, $memoryAttribute );
	}

	/**
	 * SSM: Verify if reservation cpu and memory fit within available cpu and memory
	 *
	 * @param array|CustomAttribute[] (key is custom attribute id)
	 * @param int
	 * @param int
	 * @return boolean
	 */
	public static function HasCapacity($reservationAttributes, $availCpu, $availMemory) 
	{
		$cpuNeeded = $reservationAttributes[CustomAttributes::$reservationAttrs['cpus']]->Value;
		$memoryNeeded = $reservationAttributes[CustomAttributes::$reservationAttrs['memory']]->Value;
		Log::Debug( "SSM: requested %s from %s cpus and %s from %s memory", $cpuNeeded, $availCpu, $memoryNeeded, $availMemory );
		if ( $cpuNeeded <= $availCpu && $memoryNeeded <= $availMemory ) {
			return true;
		} else {
			return false;
		}
	}
}
