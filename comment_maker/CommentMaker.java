import javax.swing.*;
import javax.swing.border.Border;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class CommentMaker {
    public static void main(String args[]) {
        // Creating the frame
        JFrame frame = new JFrame("Comment Maker");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(700, 700);

        // Top Pane
        JPanel pTop = new JPanel();
        JCheckBox cbRightWall = new JCheckBox("Enable Right Wall");
        JLabel lMax = new JLabel("Max Characters per line:");
        JTextField tfMax = new JTextField(3);
        pTop.add(lMax);
        pTop.add(tfMax);
        pTop.add(cbRightWall);

        // Center pane
        JTextArea taInput = new JTextArea();
        JTextArea taOutput = new JTextArea();
        taInput.setFont(new Font("Monospaced", Font.PLAIN, 12));
        taOutput.setFont(new Font("Monospaced", Font.PLAIN, 12));
        taInput.setLineWrap(true);
        taOutput.setText("*****\n*   *\n*****");
        taOutput.setEditable(false);

        Border border = BorderFactory.createLineBorder(Color.BLACK);
        taInput.setBorder(BorderFactory.createCompoundBorder(border,
                BorderFactory.createEmptyBorder(10, 10, 10, 10)));
        taOutput.setBorder(BorderFactory.createCompoundBorder(border,
                BorderFactory.createEmptyBorder(10, 10, 10, 10)));

        JSplitPane jsp = new JSplitPane(SwingConstants.VERTICAL, taInput, taOutput);
        jsp.setResizeWeight(0.5);
        jsp.setDividerSize(0);


        // Bottom Pane
        JPanel pBottom = new JPanel();
        JButton bGenerate = new JButton("Generate");
        pBottom.add(bGenerate);

        bGenerate.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    taOutput.setText(makeText(taInput.getText(), Integer.parseInt(tfMax.getText()), cbRightWall.isSelected()));
                } catch (NumberFormatException exp) {
                    taOutput.setText("Invalid number format");
                }
            }
        });

        // Adding to frame and setting visible
        frame.getContentPane().add(BorderLayout.NORTH, pTop);
        frame.getContentPane().add(BorderLayout.CENTER, jsp);
        frame.getContentPane().add(BorderLayout.SOUTH, pBottom);
        frame.setVisible(true);
    }

    private static String makeText(String input, int max, boolean rightWall) {
        StringBuilder str = new StringBuilder();
        StringBuilder line = new StringBuilder();
        String words[];
        boolean appended = false;

        System.out.println(rightWall);

        for (int i = 0; i < max; i++) {
            str.append("*");
        }
        str.append('\n');


        for (int i = 0; i < input.split("\n").length; i++) {
            if (input.split("\n")[i].equals("SEPARATOR")) {
                for (int j = 0; j < max; j++) {
                    str.append("*");
                }
                str.append('\n');
                continue;
            }

            words = input.split("\n")[i].split(" ");

            for (int j = 0; j < words.length; j++) {
                if (words[j].length() + 4 > max) {
                    return "Word " + words[j] + " too long";
                }
                if (line.length() + 4 + words[j].length() <= max) {
                    line.append(words[j] + " ");
                    appended = false;
                } else {
                    j--;
                    str.append("* ");
                    str.append(line);
                    if (rightWall) {
                        for (int k = 0; k + line.length() < max - 3; k++) {
                            str.append(" ");
                        }
                        str.append("*");
                    }
                    str.append("\n");
                    appended = true;
                    line = new StringBuilder();
                }
            }

            if (!appended) {
                str.append("* ");
                str.append(line);
                if (rightWall) {
                    for (int k = 0; k + line.length() < max - 3; k++) {
                        str.append(" ");
                    }
                    str.append("*");
                }
                str.append("\n");
                line = new StringBuilder();
            }
        }

        for (int j = 0; j < max; j++) {
            str.append("*");
        }

        return str.toString();

    }
}
