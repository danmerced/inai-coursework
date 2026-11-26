package kg.inai.studynotes;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import org.json.JSONArray;
import org.json.JSONException;
import java.util.ArrayList;

public class MainActivity extends Activity {
    private final ArrayList<String> notes = new ArrayList<>();
    private ArrayAdapter<String> adapter;
    private EditText input;
    private SharedPreferences preferences;

    @Override
    public void onCreate(Bundle saved) {
        super.onCreate(saved);
        preferences = getSharedPreferences("notes", MODE_PRIVATE);
        loadNotes();

        int padding = dp(20);
        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setPadding(padding, padding, padding, padding);

        TextView title = new TextView(this);
        title.setText(R.string.header);
        title.setTextSize(26);
        root.addView(title);
        input = new EditText(this);
        input.setHint(R.string.hint);
        input.setMinLines(2);
        input.setMaxLines(4);
        root.addView(input, new LinearLayout.LayoutParams(-1, -2));

        Button add = new Button(this);
        add.setText(R.string.add);
        add.setOnClickListener(v -> addNote());
        root.addView(add);

        TextView help = new TextView(this);
        help.setText(R.string.help);
        root.addView(help);

        ListView list = new ListView(this);
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, notes);
        list.setAdapter(adapter);
        root.addView(list, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 0, 1));

        list.setOnItemClickListener((parent, view, position, id) ->
                new AlertDialog.Builder(this).setMessage(notes.get(position))
                        .setPositiveButton(android.R.string.ok, null).show());
        list.setOnItemLongClickListener((parent, view, position, id) -> {
            new AlertDialog.Builder(this).setMessage(R.string.delete_question)
                    .setPositiveButton(R.string.delete, (dialog, which) -> {
                        if (position < notes.size()) {
                            notes.remove(position);
                            saveNotes();
                            adapter.notifyDataSetChanged();
                        }
                    })
                    .setNegativeButton(R.string.cancel, null).show();
            return true;
        });
        setContentView(root);
        if (saved != null) input.setText(saved.getString("draft", ""));
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        outState.putString("draft", input.getText().toString());
        super.onSaveInstanceState(outState);
    }

    private void addNote() {
        String value = input.getText().toString().trim();
        if (value.isEmpty()) {
            Toast.makeText(this, R.string.empty, Toast.LENGTH_SHORT).show();
            return;
        }
        notes.add(0, value);
        saveNotes();
        adapter.notifyDataSetChanged();
        input.setText("");
    }

    private void loadNotes() {
        try {
            JSONArray stored = new JSONArray(preferences.getString("items", "[]"));
            for (int i = 0; i < stored.length(); i++) notes.add(stored.getString(i));
        } catch (JSONException e) {
            notes.clear();
        }
    }

    private void saveNotes() {
        JSONArray data = new JSONArray(notes);
        preferences.edit().putString("items", data.toString()).apply();
    }

    private int dp(int value) {
        return (int) (value * getResources().getDisplayMetrics().density + 0.5f);
    }
}
