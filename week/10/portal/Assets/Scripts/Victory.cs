using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Victory : MonoBehaviour
{
    public GameObject Text;
    private Text textComponent;

    // Start is called before the first frame update
    void Start()
    {
        textComponent = Text.GetComponent<Text>();

        textComponent.color = new Color(0, 0, 0, 0);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnTriggerEnter(Collider other) {
        if (other.gameObject.tag == "Player") {
            textComponent.color = new Color(0, 0, 0, 1);
        }
    }
}
