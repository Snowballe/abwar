package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

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

        BtnToGame=(Button) findViewById(R.id.BtnToGame);
        BtnAdd=(Button) findViewById(R.id.BtnAdd);

        LayoutNoms=(LinearLayout)findViewById(R.id.LayoutNoms);

        TemplateEditText=(EditText)findViewById(R.id.editTextTextPersonName1);

        EditText et = new EditText(AccueilActivity.this);

        BtnToGame.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                for (int i=0;i<LayoutNoms.getChildCount();i++){
                    System.out.println(i);
                }

                Intent GoToGameActivity=new Intent(AccueilActivity.this, GameActivity.class);
                startActivity(GoToGameActivity);
            }
        });

        BtnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText et = new EditText(AccueilActivity.this);
                LayoutNoms.addView(et);
            }
        });

    }

}