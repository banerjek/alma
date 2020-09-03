#!/bin/bash

code_tables=(accessionPlacementsOptions \
AcqItemSourceType \
AcquisitionMethod \
ActiveResourcesTypes \
AddNewUserOptions \
AdminURIType \
ARTEmailDeliveryKeywords \
ARTEmailQueriesKeywords \
ARTEmailServiceKeywords \
AssertionCodes \
BaseStatus \
BLDSSDigitalFormats \
BooleanYesNo \
CalendarRecordStatuses \
CalendarRecordsTypes \
CallNumberType \
CampusListSearchableColumns \
CatalogerLevel \
CitationAttributes \
CitationAttributesTypes \
CitationCopyRights \
CollectionAccessType \
ContentStructureStatus \
CounterPlatform \
CountryCodes \
CourseTerms \
CoverageInUse \
crossRefEnabled \
CrossRefSupported \
Currency_CT \
DaysOfWeek \
DigitalRepresentationBaseStatus \
EDINamingConvention \
EdiPreference \
EdiType \
ElectronicBaseStatus \
electronicMaterialType \
ElectronicPortfolioBaseStatus \
ExpiryType \
ExternalSystemTypes \
FineFeeTransactionType \
FTPMode \
FTPSend \
FundType \
Genders \
GroupProxyEnabled \
HFrUserFinesFees.fineFeeStatus \
HFrUserFinesFees.fineFeeType \
HFrUserRoles.roleType \
HfundLedger.status \
HFundsTransactionItem.reportingCode \
HItemLoan.processStatus \
HLicense.status \
HLicense.type \
HLocation.locationType \
HPaTaskChain.businessEntity \
HPaTaskChain.type \
ImplementedAuthMethod \
IntegrationTypes \
InvoiceApprovalStatus \
InvoiceCreationForm \
InvoiceLineStatus \
InvoiceLinesTypes \
InvoiceStatus \
IpAddressRegMethod \
isAggregator \
IsFree \
ItemPhysicalCondition \
ItemPolicy \
JobsApiJobTypes \
jobScheduleNames \
JobTitles \
LevelOfService \
LibraryNoticesOptInDisplay \
LicenseReviewStatuses \
LicenseStorageLocation \
LicenseTerms \
LicenseTermsAndTypes \
LinkingLevel \
LinkResolverPlugin \
marcLanguage \
Months \
MovingWallOperator \
NoteTypes \
OwnerHierarchy \
PartnerSystemTypes \
PaymentMethod \
PaymentStatus \
PhysicalMaterialType \
PhysicalReadingListCitationTypes \
PlanTypeDefinition \
POLineStatus \
PortfolioAccessType \
PPRSourceType \
PR_CitationType \
PR_RejectReasons \
PR_RequestedFormat \
PROCESSTYPE \
provenanceCodes \
PurchaseRequestStatus \
PurchaseType \
ReadingListCitationSecondaryTypes \
ReadingListCitationTypes \
ReadingListRLStatuses \
ReadingListStatuses \
ReadingListVisibilityStatuses \
RecurrenceType \
ReminderStatuses \
ReminderTypes \
RenewalCycle \
representationEntityType \
RepresentationUsageType \
RequestFormats \
RequestOptions \
ResourceSharingCopyrightsStatus \
ResourceSharingLanguages \
ResourceSharingRequestSendMethod \
SecondReportingCode \
ServiceType \
SetContentType \
SetPrivacy \
SetStatus \
SetType \
ShippingMethod \
Sub Systems \
SystemJobReportAlertMessage \
systemJobStatus \
TagTypes \
ThirdReportingCode \
UsageStatsDeliveryMethod \
UsageStatsFormat \
UsageStatsFrequency \
UserAddressTypes \
UserBlockDescription \
UserBlockTypes \
UserEmailTypes \
UserGroups \
UserIdentifierTypes \
UserPhoneTypes \
UserPreferredLanguage \
UserRoleStatus \
UserStatCategories \
UserStatisticalTypes \
UserUserType \
UserWebAddressTypes \
VATType \
VendorReferenceNumberType \
VendorSearchStatusFilter \
WebhookEvents \
WebhooksActionType \
WorkbenchPaymentMethod) 

mkdir alma_config 2>/dev/null
mkdir alma_config/code_tables 2>/dev/null
mkdir alma_config/libraries 2>/dev/null

# Get general config 
xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/general")
echo $xmldoc |xmlstarlet fo > alma_config/general_config.xml 
echo "General configuration retrieved"

# Get departments
xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/departments")
echo $xmldoc |xmlstarlet fo > alma_config/departments.xml 
echo "Departments have been retrieved"

# Get open hours 
xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/open-hours")
echo $xmldoc |xmlstarlet fo > alma_config/open-hours.xml 
echo "Open hours have been retrieved"

# Get integration profiles 
xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/integration-profiles")
echo $xmldoc |xmlstarlet fo > alma_config/integration-profiles.xml 
echo "integration profiles have been retrieved"

# Get jobs
xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/jobs")
echo $xmldoc |xmlstarlet fo > alma_config/jobs.xml 
echo "jobs have been retrieved"

# Get printers 
xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/printers")
echo $xmldoc |xmlstarlet fo > alma_config/printers.xml 
echo "printers have been retrieved"
exit

# Get libraries
xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/libraries")

libraries=$(echo ${xmldoc} |xmlstarlet sel -t -m /libraries/library -v code -o " ")
lib_array=($libraries)

for library in ${lib_array[@]}
	do
		url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/libraries/${library}"
		filename="alma_config/libraries/${library}.xml"
	
		xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")

		echo $xmldoc |xmlstarlet fo > ${filename}
		echo "retrieved $library library record"
		mkdir alma_config/libraries/${library} 2>/dev/null

		url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/libraries/${library}/locations"
		filename="alma_config/libraries/${library}/locations.xml"
	
		xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")
		echo $xmldoc |xmlstarlet fo > ${filename}
		echo "retrieved locations for ${library}"

		#Get locations

		url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/libraries/${library}/locations/${location}"
		filename="alma_config/libraries/${library}/${location}.xml"
	
		xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")
		echo $xmldoc |xmlstarlet fo > ${filename}

		library_locations=$(echo ${xmldoc} |xmlstarlet sel -t -m locations/location -v code -o " ")
		libloc_array=($library_locations)

		for location_code in ${libloc_array[@]}
			do
				url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/libraries/${library}/locations/${location_code}"
				filename="alma_config/libraries/${library}/${location}/${location_code}.xml"
	
				xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")

				echo $xmldoc |xmlstarlet fo > ${filename}

				# get open hours
				url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/libraries/${library}/locations/${location_code}"
				filename="alma_config/libraries/${library}/${location}/${location_code}/open_hours.xml"
				xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")

				echo $xmldoc |xmlstarlet fo > ${filename}
				echo "retrieved info for location $location_code at $library "
			done
	done

exit
# Get code tables
for table in ${code_tables[@]}
	do
		url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/code-tables/${table}"
		filename="alma_config/code_tables/${table}.xml"
	
		xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")
	
		echo $xmldoc |xmlstarlet fo > ${filename}
		echo "processed table $table"
	done

