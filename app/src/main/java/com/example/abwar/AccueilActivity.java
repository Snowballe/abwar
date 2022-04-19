package com.example.abwar;


import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputFilter;

import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

import androidx.appcompat.app.AppCompatActivity;


import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

public class AccueilActivity extends AppCompatActivity {
    private Button BtnToGame;
    private Button BtnAdd;

    private LinearLayout LayoutNoms;
    private DBHandler dbHandler;

    public EditText createNewFormattedEditText(){
        EditText et = new EditText(AccueilActivity.this);
        et.setFilters(new InputFilter[] {new InputFilter.LengthFilter(64)});
        int nbJoueur = LayoutNoms.getChildCount() + 1;
        et.setHint("Joueur " + nbJoueur);
        return et;
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accueil);

        dbHandler=new DBHandler(AccueilActivity.this);
        try {
            InputStream is=AccueilActivity.this.getResources().getAssets().open("questions.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
        //todo à faire les questions avant la game, le chargement sera surement plus fluide
        dbHandler.addQuestion("Oui ?");


        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();


        BtnToGame = findViewById(R.id.BtnToGame);
        BtnAdd = findViewById(R.id.BtnAdd);

        LayoutNoms = findViewById(R.id.LayoutNoms);


        ArrayList<EditText> listeEditTexts = new ArrayList<>();

        //init de base des cases pour rentrer plus facilement des joueurs, ils sont formatés à 16 caratères max pour éviter un débordement le la question à l'écran
        //todo Ptet changer le charcater limit sur le filtre, 16 c'est coulliu mais ptet pas assez grand, mais 64 c'est vraiment trop.
        for (int i = 0; i < 4; i++) {

            EditText et = new EditText(AccueilActivity.this);
            et.setHint("Joueur N°" + (i + 1));
            et.setFilters(new InputFilter[] {new InputFilter.LengthFilter(16)});
            listeEditTexts.add(et);
            LayoutNoms.addView(et);

        }



        BtnToGame.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                ArrayList<String> mesJoueursPourLactivity = new ArrayList<>();
                for (int i = 0; i < LayoutNoms.getChildCount(); i++) {

                    Editable monJoueur = listeEditTexts.get(i).getText();
                    if (monJoueur.toString() != "") {
                        editor.putInt(monJoueur.toString(), 0);
                        editor.commit();
                        mesJoueursPourLactivity.add(monJoueur.toString());
                    }
                }
                Intent GoToDifficultyActivity = new Intent(AccueilActivity.this, DifficulteActivity.class);
                GoToDifficultyActivity.putExtra("ACCES_JOUEURS", mesJoueursPourLactivity);
                startActivity(GoToDifficultyActivity);

            }
        });

        BtnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                EditText et=createNewFormattedEditText();
                listeEditTexts.add(et);

                LayoutNoms.addView(et);
            }
        });





    }

}