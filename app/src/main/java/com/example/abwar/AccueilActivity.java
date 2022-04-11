package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.os.Bundle;
import android.text.Layout;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.io.Serializable;
import java.util.ArrayList;

public class AccueilActivity extends AppCompatActivity {
    private Button BtnToGame;
    private Button BtnAdd;

    private LinearLayout LayoutNoms;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accueil);

    SharedPreferences mesJoueurs= getSharedPreferences("MesJoueurs",0);
    SharedPreferences.Editor editor=mesJoueurs.edit();





        BtnToGame= findViewById(R.id.BtnToGame);
        BtnAdd= findViewById(R.id.BtnAdd);

        LayoutNoms= findViewById(R.id.LayoutNoms);


        ArrayList<EditText>listeEditTexts=new ArrayList<>();

        //init de base des cases pour rentrer plus facilement des joueurs
        for (int i=0;i<4;i++){
            EditText et = new EditText(AccueilActivity.this);
            et.setHint("Joueur N°"+(i+1));

            listeEditTexts.add(et);
        }



        BtnToGame.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


        //todo choper des editstexts de la scrollview et envoyer dans une array avec le intent
                for (int i=0;i<LayoutNoms.getChildCount();i++){
                    System.out.println(
                            listeEditTexts.get(i).getText()
                    );



                    //String joueur= (String) resourcesFromText.getText(LayoutNoms.getChildAt(i));
                    //TousMesjoueurs.add(joueur);
                    //editor.putInt(joueur,0);
                    //editor.commit();
                }
                Intent GoToGameActivity=new Intent(AccueilActivity.this, GameActivity.class);
                GoToGameActivity.putExtra("joueurs",listeEditTexts);
                startActivity(GoToGameActivity);
            }
        });

        BtnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText et = new EditText(AccueilActivity.this);

                int nbJoueur=LayoutNoms.getChildCount()+1;
                et.setHint("Joueur "+nbJoueur);
                listeEditTexts.add(et);
                LayoutNoms.addView(et);
            }
        });



    }

}