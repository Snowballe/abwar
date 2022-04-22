package com.example.abwar;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Build;
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
import java.util.stream.IntStream;

public class GameActivity extends AppCompatActivity {
private TextView textViewQuestion;
private String[] RawQuestions;
private List<String> ConvertedQuestions;
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

        RawQuestions=getResources().getStringArray(R.array.Questions);
        ConvertedQuestions=Arrays.asList(RawQuestions);

        //Init quand c'est la 1ere fois qu'on arrive sur la page
        int randomIndex = new Random().nextInt(RawQuestions.length);
        textViewQuestion.setText(RawQuestions[randomIndex]);



        BtnNext.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                textViewQuestion.setText("");
                int randomIndex = new Random().nextInt(ConvertedQuestions.size());
                textViewQuestion.setText(ConvertedQuestions.get(randomIndex));
                ConvertedQuestions.remove(randomIndex);
            }
        });
    }
}