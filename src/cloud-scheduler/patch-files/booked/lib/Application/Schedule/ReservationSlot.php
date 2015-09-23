<?php
/**
Copyright 2011-2014 Nick Korbel

This file is part of Booked Scheduler is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Booked Scheduler.  If not, see <http://www.gnu.org/licenses/>.
 */

require_once(ROOT_DIR . 'lib/Application/Schedule/SlotLabelFactory.php');

class ReservationSlot implements IReservationSlot
{
	/**
	 * @var Date
	 */
	protected $_begin;

	/**
	 * @var Date
	 */
	protected $_end;

	/**
	 * @var Date
	 */
	protected $_displayDate;

	/**
	 * @var int
	 */
	protected $_periodSpan;

	/**
	 * @var ReservationItemView
	 */
	private $_reservations;

	/**
	 * @var string
	 */
	protected $_beginSlotId;

	/**
	 * @var string
	 */
	protected $_endSlotId;

	/**
	 * @var SchedulePeriod
	 */
	protected $_beginPeriod;

	/**
	 * @var SchedulePeriod
	 */
	protected $_endPeriod;

	/**
	 * @var array()
	 */
	protected $_availResources;

	/**
	 * @var integer
	 */
	protected $_availCapacity;

	/**
	 * @param SchedulePeriod $begin
	 * @param SchedulePeriod $end
	 * @param Date $displayDate
	 * @param int $periodSpan
	 * @param ReservationItemView $reservation
	 */
	public function __construct(SchedulePeriod $begin, SchedulePeriod $end, Date $displayDate, $periodSpan, $reservations)
	{
		$this->_reservations = $reservations;
		$this->_begin = $begin->BeginDate();
		$this->_displayDate = $displayDate;
		$this->_end = $end->EndDate();
		$this->_periodSpan = $periodSpan;

		$this->_beginSlotId = $begin->Id();
		$this->_endSlotId = $end->Id();

		$this->_beginPeriod = $begin;
		$this->_endPeriod = $end;
	}

	/**
	 * @return Time
	 */
	public function Begin()
	{
		return $this->_begin->GetTime();
	}

	/**
	 * @return Date
	 */
	public function BeginDate()
	{
		return $this->_begin;
	}

	/**
	 * @return Time
	 */
	public function End()
	{
		return $this->_end->GetTime();
	}

	/**
	 * @return Date
	 */
	public function EndDate()
	{
		return $this->_end;
	}

	/**
	 * @return Date
	 */
	public function Date()
	{
		return $this->_displayDate;
	}

	/**
	 * SSM: Get all reservations 
	 *
	 * @return array|ReservationItemView[]
	 */
	public function GetReservations()
	{
		return $this->_reservations;
	}

        /**
	 * SSM: Get reservation count
	 *
         * @return integer
         */
        public function NumberOfReservations()
        {
                return count( $this->_reservations );
        }

	/**
	 * @return int
	 */
	public function PeriodSpan()
	{
		return $this->_periodSpan;
	}

	/**
	 * @param SlotLabelFactory|null $factory
	 * @return string
	 */
	public function Label($factory = null)
	{
		if (empty($factory))
		{
			return SlotLabelFactory::Create($this->_reservations);
		}
		return $factory->Format($this->_reservations);
	}

	public function IsReservable()
	{
		return false;
	}

	public function IsReserved()
	{
		return true;
	}

	public function IsPending()
	{
		foreach( $this->_reservations as $reservation ) {
			if ( $reservation->RequiresApproval ) {
				return true;
			}
		}
		return false;
	}

	/* true if reservation resource is starting */
	public function IsStarting()
	{
		foreach( $this->_reservations as $reservation ) {
			if ( $reservation->ReservationStarting ) {
				return true;
			}
		}
		return false;
	}

	/* true if reservation resource is running */
	public function IsRunning()
	{
		foreach( $this->_reservations as $reservation ) {
			if ( $reservation->ReservationRunning ) {
				return true;
			}
		}
		return false;
	}

	/* true if reservation resource is stopping */
	public function IsStopping()
	{
		foreach( $this->_reservations as $reservation ) {
			if ( $reservation->ReservationStopping ) {
				return true;
			}
		}
		return false;
	}

	public function IsPastDate(Date $date)
	{
		return $this->_displayDate->SetTime($this->Begin())->LessThan($date);
	}

	public function ToTimezone($timezone)
	{
		return new ReservationSlot($this->_beginPeriod->ToTimezone($timezone), $this->_endPeriod->ToTimezone($timezone), $this->Date(), $this->PeriodSpan(), $this->_reservations[0]);
	}

	public function Id()
	{
		return $this->_reservations[0]->ReferenceNumber;
	}

	public function IsOwnedBy(UserSession $user)
	{
		foreach( $this->_reservations as $reservation ) {
			if ( $reservation->UserId == $user->UserId ) {
				return true;
			}
		}
		return $false;
	}

	public function IsParticipating(UserSession $session)
	{
		foreach( $this->_reservations as $reservation ) {
			if ( $reservation->IsUserParticipating($session->UserId) || $reservation->IsUserInvited($session->UserId) ) {
				return true;
			}
		}
		return false;
	}

	public function __toString()
	{
		return sprintf("Start: %s, End: %s, Span: %s", $this->Begin(), $this->End(), $this->PeriodSpan());
	}

	public function BeginSlotId()
	{
		return $this->_beginSlotId;
	}

	public function EndSlotId()
	{
		return $this->_beginSlotId;
	}

	public function HasCustomColor()
	{
		$color = $this->Color();

		return !empty($color);
	}

	public function Color()
	{
		$color = $this->_reservations[0]->UserPreferences->Get(UserPreferences::RESERVATION_COLOR);
		if (!empty($color))
		{
			return "#$color";
		}

		return null;
	}

	public function TextColor()
	{
		$color = $this->Color();
		if (!empty($color))
		{
			return new ContrastingColor($color);
		}

		return null;
	}

	/**
	 * SSM: Get the readable description of capacity left of provided slot
	 *
         * @return string
         */
        public function GetCapacity() {
		$capacityLabel = round($this->_availCapacity*100) . '% available';
		if ( $this->_availCapacity > 0 ) {
			$capacityLabel .= " [ ";
			foreach( $this->_availResources as $key => $attribute ) {
				if ( $key > 0 ) {
					$capacityLabel .= ", ";
				}
				$capacityLabel .= $attribute->Label() . ' = ' . $attribute->Value(); 
			}
			$capacityLabel .= " ]";
		}
                return $capacityLabel;
        }

        /**
	 * SSM: Set capacity of the slot
	 * @param int
	 * @param array|CustomAttribute[]
	 *
         * @return string
         */
        public function SetCapacity( $availCapacity, $availResource ) {
        	$this->_availResources = $availResource;
        	$this->_availCapacity = $availCapacity;
        }

}
