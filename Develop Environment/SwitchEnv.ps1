## MobileWebMall
$target = "C:\91APP\nineyi.webstore.mobilewebmall\WebStore\Frontend\MobileWebMall\AppSettings.config"
$mysetting = "C:\91APP\nineyi.configuration\ApplicationConfig\NineYi.WebStore.MobileWebMall\MobileWebMall\AppSettings.QA1.MY.config"
./ManuallyReplaceAppSettings.ps1 -sourceAppSettingsConfig $target -newAppSettingsConfig $mysetting

## MobileWebMallV2
$target = "C:\91APP\nineyi.webstore.mobilewebmall\WebStore\Frontend\MobileWebMallV2\AppSettings.config"
$mysetting = "C:\91APP\nineyi.configuration\ApplicationConfig\NineYi.WebStore.MobileWebMall\MobileWebMallV2\AppSettings.QA1.MY.config"
./ManuallyReplaceAppSettings.ps1 -sourceAppSettingsConfig $target -newAppSettingsConfig $mysetting

## WebAPI
$target = "C:\91APP\nineyi.webstore.mobilewebmall\WebStore\WebAPI\AppSettings.config"
$mysetting = "C:\91APP\nineyi.configuration\ApplicationConfig\NineYi.WebStore.MobileWebMall\WebAPI\AppSettings.QA1.MY.config"
./ManuallyReplaceAppSettings.ps1 -sourceAppSettingsConfig $target -newAppSettingsConfig $mysetting

## ConnectionStrings
$target = "C:\91APP\nineyi.webstore.mobilewebmall\WebStore\Frontend\MobileWebMall\ConnectionStrings.config"
$mysetting = "C:\91APP\nineyi.configuration\MachineConfig\Frontend\ConnectionStrings.QA1.MY.config"
./ManuallyReplaceConnectionStrings.ps1 -sourceAppSettingsConfig $target -newAppSettingsConfig $mysetting
