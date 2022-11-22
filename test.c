void HeapInsert(Heap h, Item it)
{
   // is there space in the array?
   assert(h->nitems < h->nslots);
   h->nitems++;
   // add new item at end of array
   h->items[h->nitems] = it;
   // move new item to its correct place
   fixUp(h->items, h->nitems);
}

// force value at a[i] into correct position
// note that N gives max index *and* # items
void fixDown(Item a[], int i, int N)
{
   while (2*i <= N) {
      // compute address of left child
      int j = 2*i;
      // choose larger of two children
      if (j < N && less(a[j], a[j+1])) j++;
      if (!less(a[i], a[j])) break;
      swap(a, i, j);
      // move one level down the heap
      i = j;
   }
}