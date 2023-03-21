using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GemSpawner : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject[] prefabs;

    void Start()
    {
        StartCoroutine(SpawnGems());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator SpawnGems() {
		while (true) {
			// instantiate 1 gem
			Instantiate(prefabs[Random.Range(0, prefabs.Length)], new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);

			// pause 1-5 seconds until the next coin spawns
			yield return new WaitForSeconds(Random.Range(5, 10));
		}
	}
}
