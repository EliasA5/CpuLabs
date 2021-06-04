


void sort (int arr[],int sorted_arr[],int size){
    int tempSize = 0;
    

}


void insertionSort(int arr[], int n)
{
    int i, key, j;
    for (i = 1; i < n; i++)
    {
        key = arr[i];
        j = i - 1;
 
        /* Move elements of arr[0..i-1], that are
        greater than key, to one position ahead
        of their current position */
        while (j >= 0 && arr[j] > key)
        {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}



void main(){
int ID={4,3,8,2,7,2,9,3},sortedID[8],IDsize=8; //int=32bit
sort(ID,sortedID,IDsize); // IDsize=8
while(1){
 for(i=0 ; SW0=1 ; i++) show sortedID[i&0x7] on HEX0;
 delay of 1 sec;
}
}