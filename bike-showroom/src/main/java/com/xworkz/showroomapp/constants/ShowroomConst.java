package com.xworkz.showroomapp.constants;

public enum ShowroomConst {
    Jagadamba_Automobiles("Jagadamba Automobiles"), Company_Store_Bangalore("Company Store Bangalore"),
    HSR_Enterprises("HSR Enterprises"), Acclaim_Motors_Pvt_Ltd("Acclaim Motors Pvt Ltd"),
    Sri_Sadhguru_Sai_Motors("Sri Sadhguru Sai Motors"), Accelerate_Motors("Accelerate Motors"),
    Avahan_Motors_Pvt_Ltd("Avahan Motors Pvt Ltd"), Electronic_City_Motors("Electronic City Motors"),
    Company_Store_BTM("Company Store BTM"), Bommasandra_Motors("Bommasandra Motors"),
    Kormangala_Motors("Kormangala Motors");

    private final String displayName;

    ShowroomConst(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
