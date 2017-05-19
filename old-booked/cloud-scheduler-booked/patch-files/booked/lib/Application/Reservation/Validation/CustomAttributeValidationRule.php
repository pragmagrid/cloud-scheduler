<?php
/**
Copyright 2012-2014 Nick Korbel

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

class CustomAttributeValidationRule implements IReservationValidationRule
{
	/**
	 * @var IAttributeService
	 */
	private $attributeService;

	public function __construct(IResourceAvailabilityStrategy $strategy, IAttributeService $attributeService)
	{
                $this->strategy = $strategy;
		$this->attributeService = $attributeService;
	}

	/**
	 * @param ReservationSeries $reservationSeries
	 * @return ReservationRuleResult
	 */
	public function Validate($reservationSeries)
	{
		$resources = Resources::GetInstance();
		$errorMessage = new StringBuilder();

                $keyedResources = array();
                foreach ($reservationSeries->AllResources() as $resource) {
                        $keyedResources[$resource->GetId()] = $resource;
                }

                $reservations = $reservationSeries->Instances();
		$result = $this->attributeService->Validate(CustomAttributeCategory::RESERVATION, $reservationSeries->AttributeValues());
		$isValid  = $result->IsValid();
		foreach ($result->Errors() as $error) {
			$errorMessage->AppendLine($error);
		}

		if (!$isValid) {
			$errorMessage->PrependLine($resources->GetString('CustomAttributeErrors'));
			return new ReservationRuleResult($isValid, $errorMessage->ToString());
		}

                $reservations = $reservationSeries->Instances();

		// SSM: Checking capacity on resource 
                /** @var Reservation $reservation */
                foreach ($reservations as $reservation) {
                        $startDate = $reservation->StartDate();
                        $endDate = $reservation->EndDate();
                        Log::Debug("SSM: Checking for overlapping reservations, %s ", $reservation->ReferenceNumber() . "(" . $startDate .  ' - ' . $endDate . ")" );
                        if ($bufferTime != null && !$reservationSeries->BookedBy()->IsAdmin) {
                                $startDate = $startDate->SubtractInterval($bufferTime);
                                $endDate = $endDate->AddInterval($bufferTime);
                        }

			$slotStart = $startDate;
			$slotEnd = $slotStart->AddInterval(new TimeInterval(3600));
			while( $slotStart < $endDate ) {
				Log::Debug("SSM: -> Checking slot %s ", $reservation->ReferenceNumber() . "(" . $slotStart .  ' - ' . $slotEnd. ")" );
                        	$existingItems = $this->strategy->GetItemsBetween($slotStart, $slotEnd);
                        	/** @var IReservedItemView $existingItem */
				// SSM: Get overlappy reservations to verify
				$relevantReservations = array();
                        	foreach ($existingItems as $existingItem) {
					if ( ! $keyedResources[$existingItem->GetResourceId()] ) {
						continue; // ignore if not our resource
					}
					if ( $existingItem->ReferenceNumber == $reservation->ReferenceNumber() ) {
						continue; // ignore; we must be changing reservation
					}
                                	if ( ($existingItem->GetStartDate()->Equals($reservation->EndDate()) ||
                                        	$existingItem->GetEndDate()->Equals($reservation->StartDate()))
                                	) {
                                        	continue; // remove border cases
                                	}
					Log::Debug("SSM: ----> Found reservation %s on %s (%s - %s)", $existingItem->ReferenceNumber, $existingItem->GetResourceId(), $existingItem->StartDate, $existingItem->EndDate ); 
					array_push( $relevantReservations, $existingItem );
				}
				foreach( $keyedResources as $id => $resource ) {
                                	list ($capacity, $availCpus, $availMemory) = CustomAttributes::GetCapacityLeft($relevantReservations, $resource->GetAttributes() );
                                	if (! CustomAttributes::HasCapacity($reservationSeries->AttributeValues(), $availCpus, $availMemory) ) {
						$isValid = false;
						$errorMessage->AppendLine( sprintf("Reservation exceeds available capacity on resource %s (%s CPUs, %s memory) from %s - %s", $resource->GetName(), $availCpus, $availMemory, $slotStart, $slotEnd) ); 
						// only return the first slot that exceeds capacity (otherwise too many)
						return new ReservationRuleResult($isValid, $errorMessage->ToString());
					}
				}
$keyedResources[$resource->GetId()] = $resource;
				$slotStart = $slotStart->AddInterval(new TimeInterval(3600));
				$slotEnd = $slotEnd->AddInterval(new TimeInterval(3600));	
			}

		}
		return new ReservationRuleResult($isValid, $errorMessage->ToString());
	}
}
