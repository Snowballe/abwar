package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import java.util.ArrayList;

public class DifficulteActivity extends AppCompatActivity {

    private Button BtnEasy;
    private Button btnIntermediate;
    private Button btnHard;
    private Button BtnHommeDeTrois;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_difficulte);

        ArrayList<String> mesJoueursPourLactivity=getIntent().getStringArrayListExtra("ACCES_JOUEURS");
        //Obligé de se le refiler pour pouvoir garder les suites de pseudos

        BtnEasy=findViewById(R.id.BtnEasy);
        btnIntermediate=findViewById(R.id.btnIntermediate);
        btnHard=findViewById(R.id.btnHard);
        BtnHommeDeTrois=findViewById(R.id.BtnHommeDeTrois);




        BtnEasy.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent GotoGameActivity=new Intent(DifficulteActivity.this, GameActivity.class);
                GotoGameActivity.putExtra("ACCES_JOUEURS",mesJoueursPourLactivity);
                GotoGameActivity.putExtra("MaxRandInt",3);
                GotoGameActivity.putExtra("MinRandInt",1);
                startActivity(GotoGameActivity);
            }
        });

        btnIntermediate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent GotoGameActivity=new Intent(DifficulteActivity.this, GameActivity.class);
                GotoGameActivity.putExtra("ACCES_JOUEURS",mesJoueursPourLactivity);
                GotoGameActivity.putExtra("MaxRandInt",6);
                GotoGameActivity.putExtra("MinRandInt",1);
                startActivity(GotoGameActivity);
            }
        });

        btnHard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent GotoGameActivity=new Intent(DifficulteActivity.this, GameActivity.class);
                GotoGameActivity.putExtra("ACCES_JOUEURS",mesJoueursPourLactivity);
                GotoGameActivity.putExtra("MaxRandInt",10);
                GotoGameActivity.putExtra("MinRandInt",2);
                startActivity(GotoGameActivity);
            }
        });

        BtnHommeDeTrois.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent GotoTroisActivity=new Intent(DifficulteActivity.this, TroisActivity.class);
                GotoTroisActivity.putExtra("ACCES_JOUEURS",mesJoueursPourLactivity);
                startActivity(GotoTroisActivity);
            }
        });
    }

}