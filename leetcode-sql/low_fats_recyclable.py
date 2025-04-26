
# -- Finding the product ids with low fats and recycable. 
# -- SQL implementation. 
SELECT
    product_id
FROM
    Products
WHERE
    low_fats = 'Y' AND recyclable = 'Y'

# Pandas Implementation. 
import pandas as pd
def find_products(products: pd.DataFrame) -> pd.DataFrame:
    df_product_ids = products[(products[low_fats] == 'Y') & (products[recycable] == 'Y')]
    df = df[['product_id']]
    return df