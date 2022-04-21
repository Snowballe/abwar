package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class GameActivity extends AppCompatActivity {
private TextView textViewQuestion;
private String[] questions;
private Button BtnNext;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        textViewQuestion=findViewById(R.id.textViewQuestion);
        BtnNext=findViewById(R.id.BtnNext);

        ArrayList<String> mesJoueursPourLactivity=getIntent().getStringArrayListExtra("ACCES_JOUEURS");
        int MaxInt=getIntent().getIntExtra("MaxRandInt",0);
        int MinInt=getIntent().getIntExtra("MinRandInt",0);

        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();

        questions=getResources().getStringArray(R.array.Questions);
        List<String> questionsAryL= Arrays.asList(questions);

        int randomIndex = new Random().nextInt(questions.length);
        textViewQuestion.setText(questions[randomIndex]);

        BtnNext.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                textViewQuestion.setText("");
                int randomIndex = new Random().nextInt(questions.length);
                textViewQuestion.setText(questions[randomIndex]);
                //questionsAryL.remove(randomIndex);
            }
        });
    }
}