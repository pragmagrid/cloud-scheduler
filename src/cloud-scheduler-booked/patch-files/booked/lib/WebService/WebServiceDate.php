<?php

/**
 * Copyright 2012-2014 Nick Korbel
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

class WebServiceDate
{
	/**
	 * @param string $dateString
	 * @param UserSession $session
	 * @return Date
	 */
	public static function GetDate($dateString, UserSession $session)
	{
		try
		{
			if (BookedStringHelper::Contains($dateString, 'T'))
			{
				// PRAGMA: bug fix -- Booked uses a dumb timezone conversion 
				// function below called ParseExact to convert times to
				// UTC.  Instead, we use the standard PHP DateTime library 
				// to do the conversion for us so that ParseExact doesn't have
				// to actually do any conversion. 
				$localDate = DateTime::createFromFormat( DateTime::ISO8601 , $dateString);
				$localDate->setTimezone(new DateTimeZone("UTC"));
				$utcDate = $localDate->format("Y-m-d H:i:s e");
				Log::Debug( "Using DateTime to convert %s to %s", $dateString, $utcDate );
				$dateString = $localDate->format("Y-m-d H:i:s e");

				$exactDate = Date::ParseExact($dateString);
				return Date::ParseExact($dateString);
			}

			return Date::Parse($dateString, $session->Timezone);
		} catch (Exception $ex) {
			return Date::Now();
		}
	}
}
