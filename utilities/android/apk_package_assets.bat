cd "%~dp0"

REM ren assets\data.win game.droid

aapt add -f -v AM2RWrapper.apk^
 assets/AM2R.ini^
 assets/game.droid^
 assets/lang/english.ini^
 assets/lang/french.ini^
 assets/lang/czech.ini^
 assets/lang/german.ini^
 assets/lang/spanish.ini^
 assets/lang/russian.ini^
 assets/lang/japanese.ini^
 assets/lang/italian.ini^
 assets/lang/languages.txt^
 assets/lang/fonts/04b09.ttf^
 assets/lang/fonts/04b24.ttf^
 assets/lang/fonts/Acknowledge_TT_BRK.ttf^
 assets/lang/fonts/Glasstown_NBP.ttf^
 assets/lang/fonts/uni_05_53.ttf^
 assets/musalphafight.ogg^
 assets/musancientguardian.ogg^
 assets/musarachnus.ogg^
 assets/musarea1a.ogg^
 assets/musarea1b.ogg^
 assets/musarea2a.ogg^
 assets/musarea2b.ogg^
 assets/musarea3a.ogg^
 assets/musarea3b.ogg^
 assets/musarea4a.ogg^
 assets/musarea4b.ogg^
 assets/musarea5a.ogg^
 assets/musarea5b.ogg^
 assets/musarea6a.ogg^
 assets/musarea7a.ogg^
 assets/musarea7b.ogg^
 assets/musarea7c.ogg^
 assets/musarea7d.ogg^
 assets/musarea8.ogg^
 assets/muscaveambience.ogg^
 assets/muscaveambiencea4.ogg^
 assets/muscredits.ogg^
 assets/musending.ogg^
 assets/museris.ogg^
 assets/musfanfare.ogg^
 assets/musgammafight.ogg^
 assets/musgenesis.ogg^
 assets/mushatchling.ogg^
 assets/musintroseq.ogg^
 assets/musitemamb.ogg^
 assets/musitemget.ogg^
 assets/muslabambience.ogg^
 assets/musmaincave.ogg^
 assets/musmaincave2.ogg^
 assets/musmetroidappear.ogg^
 assets/musomegafight.ogg^
 assets/musqueen.ogg^
 assets/musqueen2.ogg^
 assets/musqueen3.ogg^
 assets/musqueenbreak.ogg^
 assets/musqueenintro.ogg^
 assets/musreactor.ogg^
 assets/mustitle.ogg^
 assets/mustorizoa.ogg^
 assets/mustorizob.ogg^
 assets/muszetafight.ogg

ECHO.
ECHO Signing Android APK...
java -jar uber-apk-signer.jar -a AM2RWrapper.apk

del AM2RWrapper.apk
