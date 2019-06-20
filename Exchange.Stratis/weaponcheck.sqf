    while { true } do {
        waitUntil {
            sleep 3;
            !((primaryWeapon player == "") && (secondaryWeapon player == ""))
        };
    player setCaptive false;
    };