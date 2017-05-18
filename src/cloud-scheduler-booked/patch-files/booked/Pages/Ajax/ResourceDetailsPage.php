<?php
/**
Copyright 2011-2014 Nick Korbel

This file is part of Booked Scheduler.

Booked Scheduler is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Booked Scheduler is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Booked Scheduler.  If not, see <http://www.gnu.org/licenses/>.
*/

require_once(ROOT_DIR . 'Pages/SecurePage.php');
require_once(ROOT_DIR . 'Domain/Access/namespace.php');
require_once(ROOT_DIR . 'lib/Application/Attributes/namespace.php');
require_once(ROOT_DIR . 'lib/Application/Schedule/ReservationService.php');
require_once(ROOT_DIR . 'lib/Application/Schedule/ReservationListingFactory.php');

class ResourceDetailsPage extends Page implements IResourceDetailsPage
{
    /**
     * @@var \ResourceDetailsPresenter
     */
    private $presenter;

    public function __construct()
    {
        parent::__construct('', 1);
        $this->presenter = new ResourceDetailsPresenter($this, new ResourceRepository(), new AttributeService(new AttributeRepository()));
    }

    public function PageLoad()
    {
        $this->presenter->PageLoad();

        $this->smarty->display('Ajax/resourcedetails.tpl');
    }

    public function BindResource(BookableResource $resource)
    {
        $this->Set('resourceName', $resource->GetName());
        $this->Set('resourceId', $resource->GetId());
        $this->Set('description', $resource->GetDescription());
        $this->Set('notes', $resource->GetNotes());
        $this->Set('contactInformation', $resource->GetContact());
        $this->Set('locationInformation', $resource->GetLocation());
        $this->Set('allowMultiday', $resource->GetAllowMultiday());
		$this->Set('minimumDuration', $resource->GetMinLength());
        $this->Set('maximumDuration', $resource->GetMaxLength());

        $this->Set('maxParticipants', $resource->GetMaxParticipants());
        $this->Set('maximumNotice', $resource->GetMaxNotice());
        $this->Set('minimumNotice', $resource->GetMinNotice());
        $this->Set('requiresApproval', $resource->GetRequiresApproval());
        $this->Set('autoAssign', $resource->GetAutoAssign());

        if ($resource->HasImage())
        {
            $this->Set('imageUrl', Configuration::Instance()->GetKey(ConfigKeys::IMAGE_UPLOAD_URL) . '/' . $resource->GetImage() );
        }
    }
	/*
	 * SSM: Set reservation attributes in page
	 *
	 * @param array|ReservationItemView[]
	 * @param array|CustomAttribute[]
	 * @param Timezone
	*/
	public function BindReservations( $reservations, $reservationAttributes, $userTimezone )
	{
		$this->Set('reservations', $reservations);
		$this->Set('ReservationAttributes', $reservationAttributes);
		$this->Set('userTimezone', $userTimezone);
	}

	public function BindAttributes($attributes)
	{
		$this->Set('Attributes', $attributes);
	}

    public function GetResourceId()
    {
        return ServiceLocator::GetServer()->GetQuerystring(QueryStringKeys::RESOURCE_ID);
    }

	/* SSM: Get begin date field from page
	 * 
	 * @return Date
	*/
	public function GetStartDate()
	{
		return ServiceLocator::GetServer()->GetQuerystring('startdate');
	}

	/* SSM: Get end date field from page
	 * 
	 * @return Date
	*/
	public function GetEndDate()
	{
		return ServiceLocator::GetServer()->GetQuerystring('enddate');
	}


	/**
	 * @@param ResourceType $resourceType
	 * @@param Attribute[] $attributes
	 */
	public function BindResourceType(ResourceType $resourceType, $attributes)
	{
		$this->Set('resourceType', $resourceType->Name());
		$this->Set('ResourceTypeAttributes', $attributes);
	}
}

interface IResourceDetailsPage
{
	/**
	 * @@param BookableResource $resource
	 */
	public function BindResource(BookableResource $resource);

	/**
	 * @@param Attribute[] $attributes
	 */
	public function BindAttributes($attributes);

	/**
	 * @@param ResourceType $resourceType
	 * @@param Attribute[] $attributes
	 */
	public function BindResourceType(ResourceType $resourceType, $attributes);

	/**
	 * @@return int
	 */
	public function GetResourceId();
}

class ResourceDetailsPresenter
{
    /**
     * @@var ResourceRepository
     */
    private $resourceRepository;

    /**
     * @@var IReservationService
     */
    private $reservationService;

    /**
     * @@var IResourceDetailsPage
     */
    private $page;

	/**
	 * @@var IAttributeService
	 */
    private $attributeService;

    /**
     * @@param IResourceDetailsPage $page
     * @@param IResourceRepository $resourceRepository
	 * @@param IAttributeService $attributeService
     */
    public function __construct(IResourceDetailsPage $page, IResourceRepository $resourceRepository, IAttributeService $attributeService)
    {
        $this->page = $page;
        $this->resourceRepository = $resourceRepository;
	$this->attributeService = $attributeService;
	// SSM: add reservations to this page
	$this->reservationService = new ReservationService(new ReservationViewRepository(), new ReservationListingFactory());
    }

    public function PageLoad()
    {
        $resourceId = $this->page->GetResourceId();
        $resource = $this->resourceRepository->LoadById($resourceId);
        $this->page->BindResource($resource);

		$attributeList = $this->attributeService->GetAttributes(CustomAttributeCategory::RESOURCE, $resourceId);
		$this->page->BindAttributes($attributeList->GetAttributes($resourceId));

		if ($resource->HasResourceType())
		{
			$resourceType = $this->resourceRepository->LoadResourceType($resource->GetResourceTypeId());
			$attributeList = $this->attributeService->GetAttributes(CustomAttributeCategory::RESOURCE_TYPE, $resource->GetResourceTypeId());

			$this->page->BindResourceType($resourceType, $attributeList->GetAttributes($resource->GetResourceTypeId()));
		}

	// SSM: Get active reservations to display
	$beginDate = new Date( $this->page->GetStartDate() );
	$endDate = new Date( $this->page->GetEndDate() );
	$scheduleDates = new DateRange( $beginDate, $endDate );
        $user = ServiceLocator::GetServer()->GetUserSession();

	$reservationListing = $this->reservationService->GetReservations($scheduleDates, 0, $user->Timezone);
	$resourceReservations = array();
	foreach( $reservationListing->Reservations() as $reservation ) {
		if ( $reservation->ResourceId() == $resourceId && 
			$reservation->EndDate()->GreaterThan($beginDate) && $reservation->StartDate()->LessThan($endDate) ) {
			$resourceReservations[] = $reservation;
		}
	}
	$reservationAttributes = $this->attributeService->GetAttributes(CustomAttributeCategory::RESERVATION);
        $this->page->BindReservations($resourceReservations, $reservationAttributes->GetDefinitions(), $user->Timezone );
    }
}

?>
