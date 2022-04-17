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

import java.util.ArrayList;

public class AccueilActivity extends AppCompatActivity {
    private Button BtnToGame;
    private Button BtnAdd;

    private LinearLayout LayoutNoms;

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

        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();


        BtnToGame = findViewById(R.id.BtnToGame);
        BtnAdd = findViewById(R.id.BtnAdd);

        LayoutNoms = findViewById(R.id.LayoutNoms);


        ArrayList<EditText> listeEditTexts = new ArrayList<>();

        //init de base des cases pour rentrer plus facilement des joueurs
        for (int i = 0; i < 4; i++) {

            EditText et = new EditText(AccueilActivity.this);
            et.setHint("Joueur N°" + (i + 1));
            et.setFilters(new InputFilter[] {new InputFilter.LengthFilter(64)});
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
                Intent GoToGameActivity = new Intent(AccueilActivity.this, GameActivity.class);
                GoToGameActivity.putExtra("ACCES_JOUEURS", mesJoueursPourLactivity);
                startActivity(GoToGameActivity);
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