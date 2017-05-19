{*
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
*}
<div id="resourceDetailsPopup">
	<h4>{$resourceName}</h4>

	<div style="clear"></div>
	{if $imageUrl neq ''}
		<div class="resourceImage">
			<img style="max-height:100px; max-width:100px;" src="{$imageUrl}" alt="{$resourceName|escape}"/>
		</div>
	{/if}
	<div class="description">
		<span class="bold">{translate key=Description}</span>
		{if $description neq ''}
			{$description|html_entity_decode|url2link|nl2br}
		{else}
			{translate key=NoDescriptionLabel}
		{/if}
		<br/>
		<span class="bold">{translate key=Notes}</span>
		{if $notes neq ''}
			{$notes|html_entity_decode|url2link|nl2br}
		{else}
			{translate key=NoNotesLabel}
		{/if}
		<br/>
		<span class="bold">{translate key=Contact}</span>
		{if $contactInformation neq ''}
			{$contactInformation}
		{else}
			{translate key=NoContactLabel}
		{/if}
		<br/>
		<span class="bold">{translate key=Location}</span>
		{if $locationInformation neq ''}
			{$locationInformation}
		{else}
			{translate key=NoLocationLabel}
		{/if}
		<br/>
		<span class="bold">{translate key=ResourceType}</span>
		{if $resourceType neq ''}
			{$resourceType}
		{else}
			{translate key=NoResourceTypeLabel}
		{/if}
	</div>
	<div class="attributes">
		<ul>
<!-- Disable "Usage Configuration" related resource info
			<li>
				{if $minimumDuration neq ''}
					{translate key='ResourceMinLength' args=$minimumDuration}
				{else}
					{translate key='ResourceMinLengthNone'}
				{/if}
			</li>
			<li>
				{if $maximumDuration neq ''}
					{translate key='ResourceMaxLength' args=$maximumDuration}
				{else}
					{translate key='ResourceMaxLengthNone'}
				{/if}
			</li>
			<li>
				{if $requiresApproval}
					{translate key='ResourceRequiresApproval'}
				{else}
					{translate key='ResourceRequiresApprovalNone'}
				{/if}
			</li>
			<li>
				{if $minimumNotice neq ''}
					{translate key='ResourceMinNotice' args=$minimumNotice}
				{else}
					{translate key='ResourceMinNoticeNone'}
				{/if}
			</li>
			<li>
				{if $maximumNotice neq ''}
					{translate key='ResourceMaxNotice' args=$maximumNotice}
				{else}
					{translate key='ResourceMaxNoticeNone'}
				{/if}
			</li>
			<li>
				{if $allowMultiday}
					{translate key='ResourceAllowMultiDay'}
				{else}
					{translate key='ResourceNotAllowMultiDay'}
				{/if}
			</li>
			<li>
				{if $maxParticipants neq ''}
					{translate key='ResourceCapacity' args=$maxParticipants}
				{else}
					{translate key='ResourceCapacityNone'}
				{/if}
			</li>
-->
			{if $Attributes|count > 0}
				{foreach from=$Attributes item=attribute}
					<li>
						{control type="AttributeControl" attribute=$attribute readonly=true}
					</li>
				{/foreach}
			{/if}
			{if $ResourceTypeAttributes|count > 0}
				{foreach from=$ResourceTypeAttributes item=attribute}
					<li>
						{control type="AttributeControl" attribute=$attribute readonly=true}
					</li>
				{/foreach}
			{/if}

		</ul>
	</div>

	<!-- SSM: Display reservation details in pop-up -->
	<div style="reservations">
		&nbsp;<br>
		{if $reservations|count > 0}
			<span class="bold"><u>{count($reservations)} {translate key=Reservations}</u></span>
		{/if}
		<br>
		{foreach from=$reservations item=reservation}
			<br>
			<div class="user"><span class="bold">{$reservation->GetItem()->Title}</span> ({$reservation->GetItem()->FirstName} {$reservation->GetItem()->LastName})</div>
			<div class="dates">{$reservation->StartDate()->ToTimezone($userTimezone)->Format(Date::SHORT_FORMAT)} - {$reservation->EndDate()->ToTimezone($userTimezone)->Format(Date::SHORT_FORMAT)}</div>
			<div class="dates">Status: 
				{if $reservation->GetItem()->ReservationRunning == true}
					<span style="background-color: #1c982a; color: #ffffff">&nbsp; <b>Running</b> &nbsp;</span>
				{else if $reservation->GetItem()->ReservationStarting == true}
					<span style="background-color: #2eb3a1; color: #ffffff">&nbsp; <b>Starting</b> &nbsp;</span>
				{else if $reservation->GetItem()->ReservationStopping == true}
					<span style="background-color: #ff3d17; color: #ffffff">&nbsp; <b>Stopping</b> &nbsp;</span>
				{else}
					<span style="background-color: ##408AD2; color: #ffffff">&nbsp; <b>Reserved</b> &nbsp;</span>
				{/if}
			</div>
			{foreach from=$reservation->GetItem()->Attributes->All()  key=attributeId item=attributeValue}
				{assign var=attribute value=$ReservationAttributes[$attributeId]}
				<div class="attribute"><label class="customAttribute">{$attribute->Label()}:</label><span class="attributeValue ">{$attributeValue}</span></div>
			{/foreach}
			<div class="title"><a href="reservation.php?rn={$reservation->ReferenceNumber()}">Edit</a></div>
		{/foreach}
	</div>
	<div style="clear"></div>
</div>
