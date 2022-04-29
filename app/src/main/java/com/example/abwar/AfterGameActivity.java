package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;

public class AfterGameActivity extends AppCompatActivity {

    private LinearLayout MesResultatsDeJoueurs;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_after_game);
        String LePlusGrosAlcolo = "Le/la plus gros(se) alcoolo, ";

        MesResultatsDeJoueurs = findViewById(R.id.LayoutResultats);


        ArrayList<String> mesJoueursPourLactivity = getIntent().getStringArrayListExtra("ACCES_JOUEURS");
        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();

        StringBuilder sb = new StringBuilder();
//Pour la distribution on divisera par 5 je pense
        for (int i = 0; i < mesJoueursPourLactivity.size(); i++) {



                    TextView ResMonJoueur = new TextView(AfterGameActivity.this);

                    sb.append(mesJoueursPourLactivity.get(i));

                    sb.append(" : ");
                    sb.append(mesJoueurs.getInt(mesJoueursPourLactivity.get(i),0));
                    sb.append(" gorgées bues, tu pourras distribuer ");
                    sb.append(mesJoueurs.getInt(mesJoueursPourLactivity.get(i),0)/5);
                    ResMonJoueur.setText(sb.toString());
                    MesResultatsDeJoueurs.addView(ResMonJoueur);


                    sb.setLength(0);


                }
            }

        }



