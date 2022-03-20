package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

import java.util.ArrayList;

public class AccueilActivity extends AppCompatActivity {
    private Button BtnToGame;
    private Button BtnAdd;

    private LinearLayout LayoutNoms;
    private EditText TemplateEditText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accueil);

    SharedPreferences mesjoueurs= getSharedPreferences("MesJoueurs",0);
    SharedPreferences.Editor editor=mesjoueurs.edit();

        EditText et = new EditText(AccueilActivity.this);


        BtnToGame=(Button) findViewById(R.id.BtnToGame);
        BtnAdd=(Button) findViewById(R.id.BtnAdd);

        LayoutNoms=(LinearLayout)findViewById(R.id.LayoutNoms);

        TemplateEditText=(EditText)findViewById(R.id.editTextTextPersonName1);


        BtnToGame.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ArrayList<String>TousMesjoueurs=new ArrayList<>();
//todo choper des editstexts de la scrollview et envoyer dans une array avec le intent
                for (int i=0;i<LayoutNoms.getChildCount();i++){
                    EditText et = new EditText(AccueilActivity.this);

                    Resources resourcesFromText= LayoutNoms.getChildAt(i).getResources();
                   String joueur= (String) resourcesFromText.getText(LayoutNoms.getChildAt(i));
                   TousMesjoueurs.add(joueur);
                    editor.putInt(joueur,0);
                    editor.commit();
                }
                Intent GoToGameActivity=new Intent(AccueilActivity.this, GameActivity.class);
                GoToGameActivity.putExtra("joueurs",TousMesjoueurs);
                startActivity(GoToGameActivity);
            }
        });

        BtnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText et = new EditText(AccueilActivity.this);

                int nbJoueur=LayoutNoms.getChildCount()+1;
                et.setHint("Joueur "+nbJoueur);
                LayoutNoms.addView(et);
            }
        });

    }

}