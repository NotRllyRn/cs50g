using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class PlayerDie : MonoBehaviour
{
    public GameObject floorParent;

    public static int level = 1;

    public GameObject levelText;

    public GameObject whisperSource;

    // Start is called before the first frame update
    void Start()
    {
        levelText.GetComponent<Text>().text = "Level: " + level;
    }

    // Update is called once per frame
    void Update()
    {
        if (transform.position.y < floorParent.transform.position.y - 1)
        {
            ResetLevel();
            Destroy(whisperSource);

            SceneManager.LoadScene("Gameover");
        }
    }

    public void SetLevel(int l) {
        level = l;
    }

    public void ResetLevel() {
        level = 1;
    }

    public void AddLevel(int n) {
        level += n;
    }
}
