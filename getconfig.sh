#!/bin/bash

# Retrieve global configuration parameters
get_general_config () {
	parameter=$1

	url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/${parameter}"
	filename="alma_config/${parameter}.xml" 

	xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")

	echo $xmldoc |xmlstarlet fo > ${filename}
	echo "Retrieved general $parameter configuration"
}

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

get_general_config general
get_general_config departments
get_general_config open-hours
get_general_config integration-profiles
get_general_config jobs
get_general_config printers
get_general_config libraries

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

		url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/libraries/${library}/locations"
		filename="alma_config/libraries/${library}-locations.xml"
	
		xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")
		echo $xmldoc |xmlstarlet fo > ${filename}
		echo "retrieved locations for ${library}"

	done

# Get code tables
for table in ${code_tables[@]}
	do
		url="https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/code-tables/${table}"
		filename="alma_config/code_tables/${table}.xml"
		delimitedfile="alma_config/code_tables/${table}.txt"
	
		xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "${url}")
	
		echo $xmldoc |xmlstarlet fo > ${filename}
		# create tab delimited table
		echo "code	default	description	enabled" > $delimitedfile
		echo $xmldoc |xmlstarlet sel -t -m /code_table/rows/row -v "code" -o "	" -v "default" -o "	" -v "description" -o "	" -v "enabled" -n >> ${delimitedfile}
		echo "processed table $table"
	done

